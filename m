Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E605B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2012 06:33:33 +1100 (EST)
Message-ID: <4F1F0782.3010601@freescale.com>
Date: Tue, 24 Jan 2012 13:33:22 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sridhar Addagada <sridhar_a@yahoo.com>
Subject: Re: arch/powerpc/platforms/83xx/misc.c
References: <1327383250.37748.YahooMailNeo@web120206.mail.ne1.yahoo.com>
In-Reply-To: <1327383250.37748.YahooMailNeo@web120206.mail.ne1.yahoo.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/23/2012 11:34 PM, Sridhar Addagada wrote:
> I have a hang problem on my board based on MPC8377EWLAN, here is how i
> ran into problem. We are using u-boot to load the kernel, rootfs and
> device tree.  The kernel parameters have been set
> 
> root=/dev/ram rw rootfstype=ext2 ramdisk_size=131322 console=ttyS0,115200
> 
> but I load the rootfs image generated of rootfs.jffs2

JFFS2 is for use directly from flash, not as a ramdisk.  If you want to
use JFFS2, burn it to flash and specify the appropriate mtd device.  If
you want to use an initial ramdisk, use ext2.  Or better, use initramfs
(gzipped CPIO archive).

-Scott
