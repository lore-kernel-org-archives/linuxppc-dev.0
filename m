Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYNvH3Zd0zDsSS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 22:16:27 +1000 (AEST)
In-Reply-To: <1470895395-10007-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: [1/5] powerpc/Makefile: CROSS32AS is unused, remove it
Message-Id: <3sYNvH286Dz9sxb@ozlabs.org>
Date: Tue, 13 Sep 2016 22:16:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-11-08 at 06:03:11 UTC, Michael Ellerman wrote:
> In fact it makes no sense at all to have this defined on little endian
> builds. Since we disabled the 32-bit VDSO on little endian, we don't
> build any 32-bit code when building a little endian kernel.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/d312603a44eb9dc0dbb0a642a6

cheers
