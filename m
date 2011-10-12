Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6B596B6F6F
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2011 15:18:37 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl-booke: Handle L1 D-cache parity error
 correctly on e500mc
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1314443917-18515-1-git-send-email-galak@kernel.crashing.org>
Date: Tue, 11 Oct 2011 23:18:33 -0500
Message-Id: <CEB60763-5560-4EDB-A370-CC276178A6DE@kernel.crashing.org>
References: <1314443917-18515-1-git-send-email-galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 27, 2011, at 6:18 AM, Kumar Gala wrote:

> If the L1 D-Cache is in write shadow mode the HW will auto-recover the
> error.  However we might still log the error and cause a machine check
> (if L1CSR0[CPE] - Cache error checking enable).  We should only treat
> the non-write shadow case as non-recoverable.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/include/asm/reg_booke.h |    3 +++
> arch/powerpc/kernel/traps.c          |    9 ++++++++-
> 2 files changed, 11 insertions(+), 1 deletions(-)

applied

- k
