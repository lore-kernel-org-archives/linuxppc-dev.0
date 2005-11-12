Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 567BF6872A
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 09:09:28 +1100 (EST)
Date: Sat, 12 Nov 2005 14:08:53 -0800
To: Michael Buesch <mbuesch@freenet.de>
Message-ID: <20051112220853.GB10506@pb15.lixom.net>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122145.38409.mbuesch@freenet.de>
	<Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
	<200511122237.17157.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200511122237.17157.mbuesch@freenet.de>
From: Olof Johansson <olof@lixom.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
Subject: Re: Linuv 2.6.15-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 12, 2005 at 10:37:16PM +0100, Michael Buesch wrote:

> The result of the build is:
> 
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/powerpc/kernel/built-in.o: In function `platform_init':
> : undefined reference to `prep_init'
> arch/powerpc/kernel/built-in.o:(__ksymtab+0x4d8): undefined reference to `ucSystemType'
> arch/powerpc/kernel/built-in.o:(__ksymtab+0x4e0): undefined reference to `_prep_type'
> make: *** [.tmp_vmlinux1] Error 1

Disabling CONFIG_PPC_PREP and CONFIG_PPC_CHRP will work around it for
now, neither are needed for a powermac.


-Olof
