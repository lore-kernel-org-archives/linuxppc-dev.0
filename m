Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0455CDDD04
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Apr 2007 10:30:50 +1000 (EST)
To: "Clint Thomas" <cthomas@Soneticom.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC8555CDS ELDK build issue 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Apr 2007 15:43:11 EDT."
	<3C02138692C13C4BB675FE7EA2409529327F9A@bluefin.Soneticom.local>
Date: Thu, 05 Apr 2007 02:30:48 +0200
Sender: wd@denx.de
Message-Id: <20070405003048.7769F353A31@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <3C02138692C13C4BB675FE7EA2409529327F9A@bluefin.Soneticom.local> you wrote:
> 
> Using the ELDK 4.1, I am trying to compile the linux sources for the
> MPC8555CDS. I installed the source tree provided with ELDK 4.1 (2.6.19)
> and the associated crosstools. The only factors I changed in the kernel

Try using a more recent kernel version.

> config were to set the processor arch to e500 and the platform to
> 8555CDS. When I run make, this is where it fails.

You should not change anything but just use the mpc8555_cds_defconfig
file for a start.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
1000 pains                                              = 1 Megahertz
