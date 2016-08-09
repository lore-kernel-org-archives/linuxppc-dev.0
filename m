Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sRy1JkBzDqfK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:38 +1000 (AEST)
In-Reply-To: <1470398520-20463-1-git-send-email-felix@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, mrochs@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 manoj@linux.vnet.ibm.com, ukrishn@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>, David.Laight@ACULAB.COM
Subject: Re: [v2] cxl: Use fixed width predefined types in data structure.
Message-Id: <3s7sRy07Clz9t1m@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-05-08 at 12:02:00 UTC, Philippe Bergheaud wrote:
> This patch fixes a regression introduced by commit b810253.
> 
> It substitutes the type __u8 to u8 in the uapi header cxl.h,
> because the latter is not always defined in userland build
> environments, in particular when cross-compiling libcxl on
> x86_64 linux machines (RHEL6.7 and Ubuntu 16.04).
> 
> This patch also changes the size of the field data_size, and
> makes it constant, to support 32-bit userland applications
> running on big-endian ppc64 kernels transparently.
> 
> This breaks the (young) API that has been merged in v4.8.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/cbd74e1bc8129efb9908f130a8

cheers
