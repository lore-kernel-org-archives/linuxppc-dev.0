Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C4D81A07B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 13:05:05 +1100 (AEDT)
Message-ID: <1456193101.2463.133.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: michaele@au1.ibm.com
Date: Mon, 22 Feb 2016 20:05:01 -0600
In-Reply-To: <5c8ce41d4341aa5c0698abbc0284359a789d2334.1456117980.git.sam.bobroff@au1.ibm.com>
References: <5c8ce41d4341aa5c0698abbc0284359a789d2334.1456117980.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] powerpc: Detect broken or mismatched toolchains
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-02-22 at 16:13 +1100, Sam Bobroff wrote:
> It can currently be difficult to diagnose a build that fails due to
> the compiler, linker or other parts of the toolchain being unable to
> build binaries of the type required by the kernel config. For example
> using a little endian toolchain to build a big endian kernel may
> produce:
> 
> as: unrecognized option '-maltivec'
> 
> This patch adds a basic compile test and error message to
> arch/powerpc/Makefile so that the above error becomes:
> 
> *** Sorry, your toolchain seems to be broken or incorrect. ***
> Make sure it supports your kernel configuration (ppc64).
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---

How is this more useful than getting to actually see the way in which the
toolchain (or the CFLAGS) is broken?

-Scott
