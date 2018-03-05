Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvzsk33vkzF0R7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:36:10 +1100 (AEDT)
In-Reply-To: <1519419359-19163-1-git-send-email-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Subject: Re: powerpc/boot: Fix random build errors
Message-Id: <3zvzsk1Px8z9sZf@ozlabs.org>
Date: Mon,  5 Mar 2018 23:36:09 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-02-23 at 20:55:59 UTC, Guenter Roeck wrote:
> Once in a while I see build errors similar to the following
> when building images from a clean tree.
> 
> Building powerpc:virtex-ml507:44x/virtex5_defconfig ... failed
> ------------
> Error log:
> arch/powerpc/boot/treeboot-akebono.c:37:20: fatal error:
> 	libfdt.h: No such file or directory
> 
> Building powerpc:bamboo:smpdev:44x/bamboo_defconfig ... failed
> ------------
> Error log:
> arch/powerpc/boot/treeboot-akebono.c:37:20: fatal error:
> 	libfdt.h: No such file or directory
> 
> arch/powerpc/boot/treeboot-currituck.c:35:20: fatal error:
>      libfdt.h: No such file or directory
> 
> Rebuilds will succeed.
> 
> Turns out that several source files in arch/powerpc/boot/ include
> libfdt.h, but Makefile dependencies are incomplete. Let's fix that.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/64c3f648c25d108f346fdc96c15180

cheers
