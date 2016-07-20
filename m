Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvWMz4Q4VzDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 19:10:23 +1000 (AEST)
In-Reply-To: <1468817577-1843-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: clombard@linux.vnet.ibm.com, linux-scsi@vger.kernel.org,
 mrochs@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 manoj@linux.vnet.ibm.com, imunsie@au1.ibm.com
Subject: Re: [v2] cxl: remove dead Kconfig options
Message-Id: <3rvWMz2vPGz9t0t@ozlabs.org>
Date: Wed, 20 Jul 2016 19:10:22 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-18-07 at 04:52:57 UTC, Andrew Donnellan wrote:
> Remove the CXL_KERNEL_API and CXL_EEH Kconfig options, as they were only
> needed to coordinate the merging of the cxlflash driver. Also remove the
> stub implementation of cxl_perst_reloads_same_image() in cxlflash which is
> only used if CXL_EEH isn't defined (i.e. never).
> 
> Suggested-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1e44727a0b220f6ead12fefcff

cheers
