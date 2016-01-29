Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A39F1A1A0C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 12:58:41 +1100 (AEDT)
In-Reply-To: <1453710826-3160-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/perf: Remove PPMU_HAS_SSLOT flag for Power8
Message-Id: <20160129015841.36AA6140213@ozlabs.org>
Date: Fri, 29 Jan 2016 12:58:41 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-25-01 at 08:33:46 UTC, Madhavan Srinivasan wrote:
> Commit: 7a7868326d77 introduced PPMU_HAS_SSLOT flag to
>  remove assumption of MMCRA[SLOT] with respect to
>  PPMU_ALT_SIPR flag. Commit 7a7868326d77's message also
>  specifies that Power8 does not support MMCRA[SLOT].
>  But still PPMU_HAS_SSLOT flag managed to get into
>  Power8 code. Patch to remove the same from Power8 flags.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/370f06c88528b3988fe24a372c

cheers
