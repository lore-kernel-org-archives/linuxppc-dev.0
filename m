Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS5Gq04p5zDt3c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:15:15 +1100 (AEDT)
In-Reply-To: <b7081e3aaf7867b3f9fef64e48198d3025352633.1479914776.git.geliangtang@gmail.com>
To: Geliang Tang <geliangtang@gmail.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Geliang Tang <geliangtang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: cxl: drop duplicate header sched.h
Message-Id: <3tS5Gp56wZz9vFb@ozlabs.org>
Date: Mon, 28 Nov 2016 23:15:14 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-23 at 15:27:38 UTC, Geliang Tang wrote:
> Drop duplicate header sched.h from native.c.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7184bc2ddb15d9539c701668d6a5be

cheers
