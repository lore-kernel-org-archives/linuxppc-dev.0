Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 60268679FC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Apr 2006 02:55:51 +1000 (EST)
To: Tolunay Orkun <listmember@orkun.us>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Upgrading cramfs root file system while running (DENX wrote that
	is not possible)
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 Apr 2006 23:10:39 CDT."
	<44485B3F.8080308@orkun.us>
Date: Fri, 21 Apr 2006 18:55:48 +0200
Sender: wd@denx.de
Message-Id: <20060421165548.A03E53526B7@atlas.denx.de>
Cc: White <white@from-b.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <44485B3F.8080308@orkun.us> you wrote:
>
> If your bootloader is U-Boot and you are using standard bootm command to 
> boot, U-Boot decompresses the initrd image to RAM before passing the 
> file system to Linux. So, you are not working with flash copy and 
> updating the flash copy is not a problem at all. This applies to ext2, 
> cramfs or squashfs based initrd.

But it makes no sense to use cramfs or squashfs on a ramdisk.
You *want* to run these directly from flash.
But then, of course, you need alternate images (or other tricks)
for full image updates.

[Single file updates can be done using overlay file systems; see  the
DULG for details.]

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Just about every computer on the market today runs Unix,  except  the
Mac (and nobody cares about it).                   - Bill Joy 6/21/85
