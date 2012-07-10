Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 916BB2C05A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 22:24:28 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc/mpc8572ds: Update the MSI interrupts into
 4-cell format
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341900506-23401-2-git-send-email-B38951@freescale.com>
Date: Tue, 10 Jul 2012 07:24:22 -0500
Message-Id: <751B678E-883E-4F16-ABCB-D348408A4DCC@kernel.crashing.org>
References: <1341900506-23401-1-git-send-email-B38951@freescale.com>
 <1341900506-23401-2-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 10, 2012, at 1:08 AM, Jia Hongtao wrote:

> With 2-cell format interrupts of MSI PCIe ethernet card can not work.
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |    8 ++++----
> arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    8 ++++----
> 2 files changed, 8 insertions(+), 8 deletions(-)

applied to next

- k
