Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 85F56B6F70
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2011 04:59:45 +1100 (EST)
Subject: Re: [PATCH 01/11] powerpc/85xx: Add 'fsl,
 pq3-gpio' compatiable for GPIO driver
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1319318452-27036-1-git-send-email-galak@kernel.crashing.org>
Date: Thu, 3 Nov 2011 12:59:39 -0500
Message-Id: <AC4524EB-6C7A-487D-82E1-CF32F7486D81@kernel.crashing.org>
References: <1319318452-27036-1-git-send-email-galak@kernel.crashing.org>
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


On Oct 22, 2011, at 4:20 PM, Kumar Gala wrote:

> Support MPC85xx platforms outside of MPC8572/MPC8536.  The
> MPC8572/MPC8536 have an erratum that is worked around based on having
> "fsl,mpc8572-gpio" in the compatiable list.  All other MPC85xx SoCs
> don't require this workaround and thus utilize the 'fsl,pq3-gpio'
> compatiable.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> drivers/gpio/gpio-mpc8xxx.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied

- k
