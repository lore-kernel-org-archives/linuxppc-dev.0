Date: Wed, 10 Oct 2001 21:14:53 -0700 (PDT)
From: James F Dougherty <jfd@krakatoa.gigabitnetworks.com>
Message-Id: <200110110414.f9B4Er5b005756@krakatoa.gigabitnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org, Siva.Prasad@smartm.com
Subject: Re: Intel TL82543GC gigabit Ethernet driver...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Siva,

I have to put on my Broadcom marketing hat right now.

Why don't you just use the Broadcom BCM5701? It has an integrated
10/100/1000 copper PHY, supports hardware TCP/IP/UDP and ethernet
checksumming, Dual programmable (RX/TX) 133Mhz MIPS R2K cores,
and is very cheap. Also, they have drivers and source code for
VxWorks, BSD, Windows 98/NT/2K, Solaris, Netware, and oh,
did I mention Linux, yes, fully supported with 570x doing HW
checksum of IP/UDP/TCP and ethernet!

Call me if you need me to put you in touch with the right people.
Also, if you decide to use this part, I will help you with any
network problems you have;I should know, I work on them =8^)

BTW, I am using Broadcom BCM5701 on my HHL 2.0 LinuxPPC system
right now.

Hope this helps.
					-James

James F. Dougherty
Senior Staff Engineer
jfd@broadcom.com
408-501-8273

>
> Hi,
>
> Can some one point me to the place, where I can find the latest driver for
> Intel TL82543GC Gigabit Ethernet. I want to use that on PPC 750/7400 custom
> board.
>
> I got a CD in which it has PRO 1000 driver, but it was built for 2.2.14.
> Probably, there might have been few bug fixes after that.
>
> Thanks in advance.
>
> -- Siva
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
