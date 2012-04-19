Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4A8ADB7021
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2012 06:15:49 +1000 (EST)
Subject: Re: [PATCH 2/4] powerpc/mpic_msgr: add lock for MPIC message global
 variable
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1334541908-19331-2-git-send-email-Mingkai.hu@freescale.com>
Date: Thu, 19 Apr 2012 15:15:38 -0500
Message-Id: <D5734FC8-7223-4FC0-A374-B79D41F64B88@kernel.crashing.org>
References: <1334541908-19331-1-git-send-email-Mingkai.hu@freescale.com>
 <1334541908-19331-2-git-send-email-Mingkai.hu@freescale.com>
To: Mingkai Hu <Mingkai.hu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 15, 2012, at 9:05 PM, Mingkai Hu wrote:

> Also fix issue of accessing invalid msgr pointer issue. The local
> msgr pointer in fucntion mpic_msgr_get will be accessed before
> getting a valid address which will cause kernel crash.
> 
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> ---
> arch/powerpc/sysdev/mpic_msgr.c |   10 +++++-----
> 1 files changed, 5 insertions(+), 5 deletions(-)

applied to merge

- k
