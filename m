Message-ID: <39B574B1.D7AD139A@mvista.com>
Date: Tue, 05 Sep 2000 15:33:21 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: "ZHANG,HAI-TAO (Non-A-China,ex1)" <hai-tao_zhang@non.agilent.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE on Sandpoint
References: <2F67A63DFFB1D31185D90090278CBB2D014ECAAE@apmail6.chn.agilent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes, I had to make some minor changes to the driver to get ide to work (plus
add support to sandpoint_setup.c).

Go to ftp://www.mvista.com/pub/Area51/sandpoint-8240/  and get
sandpoint.linux.tar.gz.  This is a tarball of kernel source that has IDE
working (at least on an 8240 and a 755/107).  I just put it there so let me
know if you have any problems ftp'ing it or its corrupted or something.

This kernel routes ide interrupts to the standard ISA/8259 IRQ's, namely 14 &
15.

Mark

> Hi,
>
> I have tried to boot Linux kernel on Sandpoint 603e using the nfsroot. But I
> cannot make the IDE working under Mode 1.
>
> There are some comments from MontaVista CDK1.2:
> "5) If you want to try IDE, you must route the IDE interrupts through the
> i8259; they are not wired to PCI slots 1 & 2 as the Sandpoint manual
> indicates."
>
> In the Winbond 83c553 manual, there are some registers that can route the
> IDE IRQ into 8259 (IRQ14). I have tried to set them but it does not work, do
> I need to modify the hardware? or someone has the successful experience on
> IDE disk who can help me?
>
> Thanks a lot,
> Haitao Zhang,
>

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
