Return-Path: <grave@ipno.in2p3.fr>
Received: from ipnmail.in2p3.fr (ipnmail.in2p3.fr [134.158.92.208])
	by ozlabs.org (Postfix) with ESMTP id 059D667A3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 May 2006 06:00:14 +1000 (EST)
Subject: Re: VME driver problem on MVME6100
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Konstantin Boyanov <kkboyanov@gmail.com>
In-Reply-To: <929bf310605241005q1987845di@mail.gmail.com>
References: <929bf310605241005q1987845di@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 24 May 2006 21:44:30 +0200
Message-Id: <1148499870.12398.1.camel@ipnnarval>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: grave@ipno.in2p3.fr
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Perhaps the size of the window you want is too big ?
I have only experience with MVME5100 and 5500 so I can only guess that.

xavier
Le mercredi 24 mai 2006 à 19:05 +0200, Konstantin Boyanov a écrit :
> Hi there,
> 
> These days I'm trying to "bring up" a VME driver on a Motorola SBC but
> I'm getting in some troubles.
> Actually there are no problems with the driver itself, methinks, it
> loads correctly and everithing seems to be fine.
> But when I try to create an outbound window, in order to "talk" some
> other boards in the crate I get this:
> 
> __ioremap(): phys addr 01000000 is RAM lr d100be34
> mode 0
> vmedrv: No memory for outbound window
> testout: VME_IOCTL_SET_OUTBOUND failed.  Errno = 12
> 
> I'm not sure I understand all of this anyways... Except that there is
> no sufficient memory to map for the outbound window.
> That's what this test is supposed to do is to open the appropriate
> devices for the VME bus (in this case /dev/vme_m[0-7]), configure the
> outbound windows from 0 through 6 (the 7th is reserved) and then
> verifies that data can be read through these outbound windows.
> I'm using an VME driver downloaded from vmelinux.org and here is the
> source of the test program I'm trying to run ->
> http://www-zeuthen.desy.de/~boyanov/testOutWindow.txt
> 
> I'm sorry for the newb question, but any ideas what is going wrong?
> Thank you.
> 
> Kind regards,
> Konstantin Boyanov
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
