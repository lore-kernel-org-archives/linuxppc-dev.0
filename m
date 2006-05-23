Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 715B367B14
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 21:04:45 +1000 (EST)
To: "IGOR LURI" <iluri@fagorautomation.es>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: CRAMFS: Error -3 while decompressing! 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 23 May 2006 12:15:25 +0200."
	<918EB199DDDFFA42BEA2EB3A1C6021F3D49640@correo.fagorautomation.net>
Date: Tue, 23 May 2006 13:04:43 +0200
Sender: wd@denx.de
Message-Id: <20060523110443.452953525D9@atlas.denx.de>
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

In message <918EB199DDDFFA42BEA2EB3A1C6021F3D49640@correo.fagorautomation.net> you wrote:
> 
> We would want to use a Compact Flash card with VFAT file system to boot
> our system, so we need to store a linux kernel image and an initrd image
> on it.

Did you read http://www.denx.de/wiki/view/DULG/RootFileSystemInAReadOnlyFile ???

> U-Boot can load linux kernel image and initrd from Compact Flash to RAM.

No need to waste memory on a (big) ramdisk.

> We haven't choose already the initrd file system type, but CRAMFS is an
> option. However, as I mentioned in the previos message, a CRAMFS initrd
> doesn´t boot in our board.

cramfs makes no sense on a ramdisk image. Use ext2.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
In theory, there is no difference between  theory  and  practice.  In
practice, however, there is.
