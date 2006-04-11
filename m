Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (71-214-132-244.roch.qwest.net
	[71.214.132.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8722C67A5C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 07:55:53 +1000 (EST)
Subject: Re: NAND and JFFS2 supports in Linux 2.4
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Laurent Lagrange <lagrange@fr.oleane.com>
In-Reply-To: <000001c65d85$5e699890$5201a8c0@GEG2400>
References: <000001c65d85$5e699890$5201a8c0@GEG2400>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 16:19:35 -0500
Message-Id: <1144790375.3659.3.camel@yoda.jdub.homelinux.org>
Mime-Version: 1.0
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

On Tue, 2006-04-11 at 18:31 +0200, Laurent Lagrange wrote:
> Hello,
> 
> I work on a custom 82xx board with a NAND flash :
> NAND device: Manufacturer ID: 0xec, Chip ID: 0xf1 (Samsung NAND 128MiB 3,3V
> 8-bit)
> 
> I have to KEEP a Linux 2.4 and can't migrate to a Linux 2.6 for this board.
> 
> This type of NAND flash and JFFS2 work fine with a Linux 2.6 but with a
> Linux 2.4,
> this is a little tricky :
> Linux 2.4.18 or 2.4.25 do not support this device,

Those are entire too old.

> Linux 2.4.31 seems supporting this device but JFFS2 is not adapted,

NAND + JFFS2 + 2.4 is not a supported combination.
 
> Linux 2.4.32 does not support this device anymore.

Odd.  Do you have a diff from .31 to .32?

> On www.linux-mtd.infradead.org, it seems that Linux 2.4 is no more
> supported.

Well, 2.4 is supported but no new features go in that tree.  Including
NAND support in JFFS2.  If there is a bug in the 2.4 code that is
present in MTD/JFFS2 it can certainly still be fixed.

> 
> Any help would be welcome

You might try your luck with patching the latest 2.4 kernel with MTD
CVS.  But be warned that quite a few things have changed, so you'd have
to essentially backport.

And keep in mind that it's not supported.

josh
