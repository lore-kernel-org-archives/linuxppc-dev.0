Return-Path: <vvv75@yandex.ru>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id AEFDA67AAC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Jan 2005 19:34:20 +1100 (EST)
Message-ID: <41F602F8.1090007@yandex.ru>
Date: Tue, 25 Jan 2005 11:27:36 +0300
From: Vitaly Bordug <vvv75@yandex.ru>
MIME-Version: 1.0
To: ningmin@yahoo.co.jp, linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=KOI8-R; format=flowed
Subject: Re: Serial console problem on MPC8272ADS board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ning,
Well, AFAIK the serial console on the second UART (and second UART on 
SCC4 as well) haven't been included yet to the community tree. To be 
sure you can take a look in the 8260_io/uart.c where in rs_table 
structure second entry should be {0, 0, PROFF_SCC4 ... Implementation is 
not that hard, you need only make proper mentioned entry, enable 
transceiver (BCSR+4), and program parallel port pins (take a look at 
chapter 37 of MPC8272 reference manual, grep for SCC4).

--
Regards, Vitaly
