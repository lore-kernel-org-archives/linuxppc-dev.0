Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3FF91D0F.7010203@dgt-lab.com.pl>
Date: Mon, 05 Jan 2004 09:15:11 +0100
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: memory problem with fec on 8250
References: <200401041555.JAA03904@lists.linuxppc.org>
In-Reply-To: <200401041555.JAA03904@lists.linuxppc.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


U¿ytkownik Samo Pogacnik napisa³:

>Hello!
>
>Is it possible that there is something wrong in the way how the:
>"netif_wake_queue(dev)" gets called from the interrupt handler in the
>"fcc_enet.c"?
>I can confirm this problem for 2.4.18 as well as 2.6.0 kernels on mpc82xx.
>
>bye, Samo
>
>
>
>
i don't know exactly what's wrong with 82xx code,
but i wrote a small patch that frees unfreed skbuf before allocating new
one,
and now it works fine

additionaly, i had no problem with (almost) the same code on 8xx

--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
