Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DC4822C0094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 08:14:36 +1100 (EST)
Subject: Re: [PATCH][v2] powerpc: add missing deo arch category to
 e500mc/e5500 dts
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1362523149-19393-2-git-send-email-stuart.yoder@freescale.com>
Date: Tue, 12 Mar 2013 16:14:30 -0500
Message-Id: <B38D1686-ADF8-4EEF-96A4-9C518FE92E98@kernel.crashing.org>
References: <1362523149-19393-1-git-send-email-stuart.yoder@freescale.com>
 <1362523149-19393-2-git-send-email-stuart.yoder@freescale.com>
To: Stuart Yoder <stuart.yoder@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 5, 2013, at 4:39 PM, Stuart Yoder wrote:

> From: Stuart Yoder <stuart.yoder@freescale.com>
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
> 
> -v2
>   -deo is EREF specific, changed name of property
> 
> arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi |    1 +
> arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi  |    1 +
> 2 files changed, 2 insertions(+)

applied to next

- k
