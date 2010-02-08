Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 4D0BFB7CEE
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2010 09:48:16 +1100 (EST)
To: John Williams <john.williams@petalogix.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: simpleImage.XX and large kernels
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1d3f23371002080247j17138famcf4e4aebc1ae04f5@mail.gmail.com>
References: <1d3f23371002080247j17138famcf4e4aebc1ae04f5@mail.gmail.com>
Date: Mon, 08 Feb 2010 23:48:12 +0100
Message-Id: <20100208224812.CBED7A87D1A@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear John Williams,

In message <1d3f23371002080247j17138famcf4e4aebc1ae04f5@mail.gmail.com> you wrote:
> 
> I'm looking at the simpleImage.XXX make target (PPC 405/440), and it
> seems that by default the arch/powerpc/boot/wrapper script places the
> bootwrapper at 0x400000, effectively setting a limit on the maximum
> bootable kernel size.
> 
> For various reasons we'd like to be able to put a fairly complete
> rootfs as an initramfs, which obviously blows past a 4Mbyte limit very
> quickly.  Short of adding a new 'platform' option and associated
> hackery through the powerpc/boot Makefiles and wrapper, is there a
> quick and clean way I can tell the boot wrapper to link at a higher
> address?

Is there any specific reason why you want to use simpleImage, instead
of using a normal uImage either bundled with your ramdisk image as a
classic multifile image, or (recommended) as a FIT image?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It's all Klatchian to me.
        - Terry Pratchett & Stephen Briggs, _The Discworld Companion_
