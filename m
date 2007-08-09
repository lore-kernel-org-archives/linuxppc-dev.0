Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41F2DDDEC7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 23:56:34 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IJ8Uz-0004AD-EA
	for linuxppc-embedded@ozlabs.org; Thu, 09 Aug 2007 15:56:25 +0200
Received: from p5497ff37.dip.t-dialin.net ([84.151.255.55])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 09 Aug 2007 15:56:25 +0200
Received: from dzu by p5497ff37.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 09 Aug 2007 15:56:25 +0200
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Were to start? With MPC8272 and embedded Linux.
Date: Thu, 09 Aug 2007 15:56:40 +0200
Message-ID: <m2k5s4yfon.fsf@ohwell.denx.de>
References: <fccc6f400708070536y366c0fcbt18f77d5aaacfb7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Channy,

> We're starting a project with an MPC8272 that will eventually be on a custom
> board we are building. 
>
> Here is a list of things I have:
>
> - EmbeddedPlanet with MPC8272 but no BSP (do I need one?)

You need a kernel that supports your specific board, yes.  According
to the Embedded Planet web page, there should be a 2.6.10 BSP
available.  This will be based on arch/ppc being dead in less than
twelve months, so for the long term you should start looking for
support for your board in recent kernels, i.e. arch/powerpc.

> - VisionProbe II with VisionClick
>
> I am planning on using DENX and U-Boot.

Congratulations.  We will be perfectly happy helping you on a
professional basis, but maybe you only want to use our free toolchain
ELDK, though :)

> Can I put a Linux image with the VisionProbe II?

Put where?  In RAM, in flash?  I would think that any self-respecting
JTAG debugger should be capable of doing this, but I only know the
BDI2000.

Cheers
  Detlev

-- 
In God we trust.  All others we monitor
                       -- NSA motto
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
