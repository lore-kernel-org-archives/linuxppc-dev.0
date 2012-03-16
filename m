Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0A222B7A62
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:24:58 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl_msi : return proper error value when ioremap
 failed.
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331246857-5622-1-git-send-email-soniccat.liu@gmail.com>
Date: Fri, 16 Mar 2012 10:24:37 -0500
Message-Id: <8A22B23A-8658-4FAC-8EDA-95C07F370A25@kernel.crashing.org>
References: <1331246857-5622-1-git-send-email-soniccat.liu@gmail.com>
To: soniccat.liu@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 8, 2012, at 4:47 PM, soniccat.liu@gmail.com wrote:

> From: Liu Shuo <soniccat.liu@gmail.com>
> 
> Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
> ---
> arch/powerpc/sysdev/fsl_msi.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied

- k
