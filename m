Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <8D7C5F56B409554D9D46AC22195807F3061A2F@exchwenz01.smtp.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: 
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: MPC860T FEC problem 
Date: Tue, 10 Sep 2002 02:58:50 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 -----Original Message-----
From: 	Wolfgang Denk [mailto:wd@denx.de]
Sent:	Saturday, September 07, 2002 10:15 AM
To:	o_y
Cc:	linuxppc-embedded@lists.linuxppc.org
Subject:	Re: MPC860T FEC problem


Hi,

in message <MBBBIOFIICDAPDMKHBDEKEDLCAAA.o_yahav@netvision.net.il> you
wrote:
>
> I'm trying to port linux 2.2.14 on MPC860T and busybox as initrd.

2.2.14 is prehistoric stuff. Don't waste your time on  all  the  bugs
and problems that have been fixed since.

We are using this kernel and it is working find for us.

> I have not seen any initializetion of the BCSR4 so i initialize it with
the
> value
> that ppcboot uses , so the ENABLE led is on too.

Ummm... What's BCSR4? If PPCBoot initializes it, why do you  have  to
initialize it again?

Like Wolfgang said why reinvent the wheel

> The device isn't working even when i use ppcboot (i configured ppcboot to
> use it).

Sic! So get PPCBoot running first.

> 1. Why there is no initializetion of BCSR4 in the original code?
> 2. If BCSR4 must be initialized , what is the correct value?
> 3. Is any one have a code that succeeded getting FEC device to work?

Most of this depends on your hardware.  We are using the FEC with this
kernel version and it is working fine.  Get the 2.2.14 kernel from
Wolfgang's FTP site if it is still on there the FEC code and lots of other
goodies work with this kernel version.

Sometimes you cannot upgrade to a new kernel version this is possibly
political and not a design decision.  Sometime there is also no reason to
upgrade to a newer kernel version and have to retest all possible variants
of device with the new kernel version.

Regards,
Rod Boyce

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
