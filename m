Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7B558100F8F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 17:41:31 +1100 (EST)
Subject: Re: [PATCH 4/4] powerpc/83xx: make mpc830x_rdb use mpc83xx_setup_pci
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1321541330-2330-4-git-send-email-dbaryshkov@gmail.com>
Date: Thu, 24 Nov 2011 00:40:57 -0600
Message-Id: <47422793-6FDB-4247-A7B6-6F25905FDF76@kernel.crashing.org>
References: <1321541330-2330-1-git-send-email-dbaryshkov@gmail.com>
 <1321541330-2330-4-git-send-email-dbaryshkov@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 17, 2011, at 8:48 AM, Dmitry Eremin-Solenikov wrote:

> Traditionally mpc830x_rdb board file searched for mpc8308-pcie devices.
> However both in-kernel dts from the beginning declared those pcie units
> as compatible with mpc8314-pci, which is handled by mpc83xx_setup_pci().
> 
> Drop special handling for mpc8308 and use common function instead.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/platforms/83xx/mpc830x_rdb.c |   12 +-----------
> 1 files changed, 1 insertions(+), 11 deletions(-)

applied to next

- k
