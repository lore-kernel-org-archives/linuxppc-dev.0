Message-Id: <200401052252.QAA10493@lists.linuxppc.org>
Content-Type: text/plain;
  charset="iso-8859-2"
From: Samo Pogacnik <samo.pogacnik@s5.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: memory problem with fec on 8250
Date: Mon, 5 Jan 2004 23:52:33 +0100
References: <200401041555.JAA03904@lists.linuxppc.org> <3FF91D0F.7010203@dgt-lab.com.pl>
In-Reply-To: <3FF91D0F.7010203@dgt-lab.com.pl>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Monday 05 January 2004 09:15, Wojciech Kromer wrote:
> U¿ytkownik Samo Pogacnik napisa³:
> >
> >Is it possible that there is something wrong in the way how the:
> >"netif_wake_queue(dev)" gets called from the interrupt handler in the
> >"fcc_enet.c"? I can confirm this problem for 2.4.18 as well as 2.6.0
> >kernels on mpc82xx.
>
> i don't know exactly what's wrong with 82xx code, but i wrote a small
> patch that frees unfreed skbuf before allocating new one, and now it
> works fine
>
> additionaly, i had no problem with (almost) the same code on 8xx

hi, Wojciech
can you send the patch?
did you free skbuffs from the irq handler or somewhere else?

when i run netperf (snapshot) test using the 100Mbps connection, this
test eats all the available RAM. the /proc/meminfo shows that most of the used
memory at that point is been held by internal kernel structures (Slab).

by, Samo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
