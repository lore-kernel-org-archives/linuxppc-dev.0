From: v.sudeep@exgate.tek.com
Message-ID: <301A812E6528D511A8F70008C71E57860290FC63@ap-bang-m02.india.tek.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Parallel port in 405GP?
Date: Mon, 5 Jan 2004 21:17:52 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi !!!

I am a newbie to embedded and linux. And I want to know if the IBM Walnut
405GP board has a parallel port. From the meagre documentation that I have
read, I find nothing to suggest that it has. Am I right on this one ??

Thanks in advance.

- S u d e e p    V
Don't change horses in mid stream.





-----Original Message-----
From: Samo Pogacnik [mailto:samo.pogacnik@s5.net]
Sent: Tuesday, January 06, 2004 4:23 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: memory problem with fec on 8250



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
test eats all the available RAM. the /proc/meminfo shows that most of the
used
memory at that point is been held by internal kernel structures (Slab).

by, Samo


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
