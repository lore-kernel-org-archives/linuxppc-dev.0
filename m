Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 416F7DE389
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 23:11:09 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: jwboyer@linux.vnet.ibm.com
Subject: Re: [U-Boot-Users] AMCC PPC440EPx/sequoia stability question...
Date: Thu, 24 Apr 2008 15:06:17 +0200
References: <480EADF4.2020706@verizon.net> <200804240636.12349.sr@denx.de>
	<1209038406.2946.20.camel@vader.jdub.homelinux.org>
In-Reply-To: <1209038406.2946.20.camel@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200804241506.17386.sr@denx.de>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 24 April 2008, Josh Boyer wrote:
> > This depends. When the bootwrapper version is used then yes, the kernel
> > should get changed. This is because the bootwrapper detects the SDRAM
> > size from the DDR2 controller and passes it to Linux.
> >
> > Without bootwrapper no changes are needed, since U-Boot already passes
> > the corrected memory size to Linux (totalsize-4k currently).
>
> Hm.  Given that AMCC ships the boards with an older U-Boot that requires
> cuImages, I think we'll need to patch the wrapper.

Yes, this should be done too. I forgot about it since I usually don't use the 
wrapper.

> Does 440GRx share 
> this same errata?  I would think so.

Yep. Same problem on 440GRx.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
