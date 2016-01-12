Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 170261A1071
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 23:32:52 +1100 (AEDT)
In-Reply-To: <1452481144-26173-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: cseo@linux.vnet.ibm.com, sjmunroe@us.ibm.com, adhemerval.zanella@linaro.org,
 tuliom@linux.vnet.ibm.com
Subject: Re: powerpc: Add HWCAP bits for Power9
Message-Id: <20160112123251.6A37314010F@ozlabs.org>
Date: Tue, 12 Jan 2016 23:32:50 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-01 at 02:59:04 UTC, Michael Ellerman wrote:
> In order to support Power9 we need two new HWCAP bits. We are merging
> these ahead of the cputable entry so that glibc can start referring to
> them.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/e708c24cd01ce80b1609d8bacc

cheers
