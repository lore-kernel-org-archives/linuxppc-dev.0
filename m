Return-Path: <john.williams@petalogix.com>
Received: from mail-px0-f194.google.com (mail-px0-f194.google.com
	[209.85.216.194]) by ozlabs.org (Postfix) with ESMTP id 8D2F1B7D1C
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 21:47:45 +1100 (EST)
Received: by pxi32 with SMTP id 32so2651332pxi.15
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Feb 2010 02:47:44 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 8 Feb 2010 20:47:44 +1000
Message-ID: <1d3f23371002080247j17138famcf4e4aebc1ae04f5@mail.gmail.com>
Subject: simpleImage.XX and large kernels
From: John Williams <john.williams@petalogix.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm looking at the simpleImage.XXX make target (PPC 405/440), and it
seems that by default the arch/powerpc/boot/wrapper script places the
bootwrapper at 0x400000, effectively setting a limit on the maximum
bootable kernel size.

For various reasons we'd like to be able to put a fairly complete
rootfs as an initramfs, which obviously blows past a 4Mbyte limit very
quickly.  Short of adding a new 'platform' option and associated
hackery through the powerpc/boot Makefiles and wrapper, is there a
quick and clean way I can tell the boot wrapper to link at a higher
address?

Thanks,

John
