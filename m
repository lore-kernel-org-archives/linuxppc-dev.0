Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B3552B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Sep 2010 20:07:09 +1000 (EST)
Message-ID: <4C8F49A1.9050008@windriver.com>
Date: Tue, 14 Sep 2010 18:08:33 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Generating elf kernel ?
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201009141053.11946.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guillaume Dargaud wrote:
> Hello all,
> In the past I've been using the PPC architecture to generate elf kernels (I 
> wrote my own bootloader):
> $ file zImage.elf 
> zImage.elf: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 
> (SYSV), statically linked, not stripped
> 
> I'm now trying to change to the PowerPC architecture, but the generated kernel 
> is different and won't load:
> $ file zImage
> zImage: u-boot/PPCBoot image
> 
> How do I generate an elf file ?

Try simpleImage/dtbImage. But you have to check if there is a file,
arch/powerpc/boot/<platform>.c.

For more detail on this please refer to Documentation/powerpc/bootwrapper.txt.

> For what it's worth, I use the Xilinx-patched kernel and I load it to a flash 
> mem using impact.

Which bootloader? Looks you want to run it as XIP.

Tiejun
