Return-Path: <kumar.gala@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3AD4AB70B3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Jan 2011 11:23:46 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: fix compatible properties of the P1022DS
	DMA nodes used for audio
MIME-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1291395134-12435-1-git-send-email-timur@freescale.com>
Date: Wed, 12 Jan 2011 18:08:29 -0600
Message-ID: <F8A5F136-1479-4DAC-971A-448134B51987@freescale.com>
References: <1291395134-12435-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 3, 2010, at 10:52 AM, Timur Tabi wrote:

> In order to prevent the fsl_dma driver from claiming the DMA channels =
that the
> P1022DS audio driver needs, the compatible properties for those nodes =
must say
> "fsl,ssi-dma-channel" instead of "fsl,eloplus-dma-channel".
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> Kumar, please pick up this patch for 2.6.37.
>=20
> arch/powerpc/boot/dts/p1022ds.dts |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied to next

- k=
