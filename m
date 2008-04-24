Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 72527DDEC6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 14:39:27 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: jwboyer@linux.vnet.ibm.com
Subject: Re: [U-Boot-Users] AMCC PPC440EPx/sequoia stability question...
Date: Thu, 24 Apr 2008 06:36:12 +0200
References: <480EADF4.2020706@verizon.net> <200804231449.24746.sr@denx.de>
	<1208999427.2946.8.camel@vader.jdub.homelinux.org>
In-Reply-To: <1208999427.2946.8.camel@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200804240636.12349.sr@denx.de>
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
> > Please note that I recently introduced a CFG_MEM_TOP_HIDE option for the
> > 440EPx CHIP 11 errata. I suggest you take a look at this too and see if
> > this changes your behavior.
>
> Explain this a bit more please?  Is a kernel change needed here?

This depends. When the bootwrapper version is used then yes, the kernel should 
get changed. This is because the bootwrapper detects the SDRAM size from the 
DDR2 controller and passes it to Linux.

Without bootwrapper no changes are needed, since U-Boot already passes the 
corrected memory size to Linux (totalsize-4k currently).

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
