Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED200B6F76
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2011 19:26:42 +1100 (EST)
Subject: Re: checking status semantics with compatible functions
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <9BC4C90E-090F-4961-A242-10D769C08738@kernel.crashing.org>
Date: Wed, 30 Mar 2011 03:26:29 -0500
Message-Id: <C1B3133E-0EEE-49E9-9E3A-35026CFA78E9@kernel.crashing.org>
References: <9BC4C90E-090F-4961-A242-10D769C08738@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Adding proper lists on CC]

- k

On Mar 30, 2011, at 3:07 AM, Kumar Gala wrote:

> Grant,
>=20
> We have a few helper functions like:
>=20
> drivers/of/base.c:EXPORT_SYMBOL(of_device_is_compatible);
> drivers/of/base.c:EXPORT_SYMBOL(of_find_compatible_node);
>=20
> That we use in places like arch/powerpc/platform/85xx/mpc85xx_ds.c:
>=20
>        for_each_node_by_type(np, "pci") {
>                if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
>                    of_device_is_compatible(np, "fsl,mpc8548-pcie") ||
>                    of_device_is_compatible(np, "fsl,p2020-pcie")) {
>=20
> It seems like we should check 'status' in these cases with =
'of_device_is_available'.  I'm thinking that we should have versions of =
the helpers that also do the 'of_device_is_available' checking.  Or =
should we just change the helpers to call of_device_is_available?
>=20
> - k
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
