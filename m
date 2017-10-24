Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLm9r2dWvzDqmj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:08:32 +1100 (AEDT)
In-Reply-To: <20171012021659.30134-1-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/configs: Enable I2C_CHARDEV for pseries and powernv
Message-Id: <3yLm9r1rCMz9s76@ozlabs.org>
Date: Tue, 24 Oct 2017 19:08:31 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-10-12 at 02:16:59 UTC, Andrew Donnellan wrote:
> i2c-dev provides an interface for userspace programs to interact with I2C
> devices, and is very helpful for I2C-related debugging.
> 
> Enable it in pseries_defconfig and powernv_defconfig. It's already enabled
> in many other powerpc defconfigs.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/deed2ec5a786f037b00136792e0840

cheers
