from django.shortcuts import render
from rest_framework import generics
from .models import Cupom
from .serializer import CupomSerializer

# Create your views here.
# ATENDIMENTO

# Create your views here.
class CupomGetCreate(generics.ListCreateAPIView):
    queryset = Cupom.objects.all()
    serializer_class = CupomSerializer

# API para Alterar/Excluir agendamento
class CupomUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Cupom.objects.all()
    serializer_class = CupomSerializer


from datetime import datetime
from time import sleep
from threading import Thread
import pytz 

utc=pytz.UTC

def invalidate_coupon():
    a = 0
    while True:
        coupons = Cupom.objects.all()
        current = datetime.today().replace(tzinfo=utc)

        #ct = datetime.strptime(datetime.now(tz=pytz.timezone('America/Sao_Paulo')).isoformat(), '%d/%m/%y %H:%M:%S')

        #print(current)
        #if current < datetime.now(tz=pytz.timezone('America/Sao_Paulo')):
        #    print('oi')
        #print(datetime.now(tz=pytz.timezone('America/Sao_Paulo')))
        #valid_date = valid_date.replace(tzinfo=utc)
        #print(valid_date, type(valid_date))
        for coupon in coupons:
            dat_expiracao = coupon.dat_expiracao.replace(tzinfo=utc)
            #print(dat_expiracao)
            #expiration_date = expiration_date.replace(tzinfo=utc)
            #print(coupon.expiration_date, type(coupon.expiration_date))
            if dat_expiracao < current and coupon.des_status == 'A':
                print(coupon.num_valor,' ', coupon.dat_expiracao, 'venceu', current)
                coupon.des_status = 'E'
                coupon.save()
        a += 1
        print(a)
        sleep(5)

func = Thread(target=invalidate_coupon)
func.daemon = True
func.start()