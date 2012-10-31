Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 543BE2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2012 00:25:57 +1100 (EST)
Subject: Re: [PATCH 2/6] powerpc: Define CPU_FTR_HAS_PPR
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1351666334.32304.13.camel@hbabu-laptop>
Date: Wed, 31 Oct 2012 08:25:35 -0500
Message-Id: <423B952B-AB58-4BAB-87EE-9F666615AB6C@kernel.crashing.org>
References: <1351666334.32304.13.camel@hbabu-laptop>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Cc: mikey@neuling.org, anton@au1.ibm.com, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 31, 2012, at 1:52 AM, Haren Myneni wrote:

> [PATCH 2/6] powerpc: Define CPU_FTR_HAS_PPR
> 
> CPU_FTR_HAS_PPR is defined for POWER7.

Would be nice if commit message spelled out what PPR is.

> 
> Signed-off-by: Haren Myneni <haren@us.ibm.com>
> ---
> arch/powerpc/include/asm/cputable.h |    6 ++++--
> 1 files changed, 4 insertions(+), 2 deletions(-)
