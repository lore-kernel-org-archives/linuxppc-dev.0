Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D2CEB7128
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 22:59:23 +1100 (EST)
Subject: Re: [PATCH 3/3] powerpc/85xx: Update of_platform_bus_probe list to
	include PCI controller
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1288934910-3202-1-git-send-email-b25806@freescale.com>
Date: Thu, 11 Nov 2010 05:59:10 -0600
Message-Id: <90A4C584-325F-4E5D-8D3C-1B5797F4CAC0@kernel.crashing.org>
References: <1288934910-3202-1-git-send-email-b25806@freescale.com>
To: Lan Chunhe <b25806@freescale.com>
Cc: "Kai.Jiang" <Kai.Jiang@freescale.com>, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 5, 2010, at 12:28 AM, Lan Chunhe wrote:

> We need to get the pci controller created as an of platform device to
> allow the EDAC driver to bind to it on P4080DS.
>=20
> Signed-off-by: Kai.Jiang <Kai.Jiang@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Lan Chunhe <b25806@freescale.com>
> ---
> arch/powerpc/platforms/85xx/corenet_ds.c |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c =
b/arch/powerpc/platforms/85xx/corenet_ds.c
> index 2ab338c..bf9b9e5 100644
> --- a/arch/powerpc/platforms/85xx/corenet_ds.c
> +++ b/arch/powerpc/platforms/85xx/corenet_ds.c
> @@ -116,6 +116,9 @@ static const struct of_device_id of_device_ids[] =
__devinitconst =3D {
> 	{
> 		.compatible	=3D "fsl,rapidio-delta",
> 	},
> +	{
> +		.compatible	=3D "fsl,p4080-pcie",
> +	},
> 	{}
> };
>=20

We've talked about doing an explicit add of a new node instead of doing =
this everywhere.  I'd like to see that done instead.

- k
> --=20
> 1.5.4.5
>=20
