Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0C513DDE39
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 20:04:45 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6NA4dR8004320
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 03:04:40 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6NA4chY003770
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 05:04:39 -0500 (CDT)
Subject: Re: [PATCH 5/6 v2] 85xxCDS: Misc 8548 PCI Corrections.
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Randy Vinson <rvinson@mvista.com>
In-Reply-To: <46A137C1.3080105@mvista.com>
References: <46A10578.6030609@mvista.com>
	<DF1A9889-840C-4D19-9824-177DFEFE298F@kernel.crashing.org>
	<46A133CF.6010407@mvista.com>  <46A137C1.3080105@mvista.com>
Content-Type: text/plain
Message-Id: <1185185072.25737.1.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 23 Jul 2007 18:04:32 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-07-21 at 06:31, Randy Vinson wrote:

> @@ -272,10 +272,10 @@ static void __init mpc85xx_cds_setup_arch(void)
>         for (np = NULL; (np = of_find_node_by_type(np, "pci")) !=
> NULL;) {
>                 struct resource rsrc;
>                 of_address_to_resource(np, 0, &rsrc);
> -               if ((rsrc.start & 0xfffff) == 0x9000)
> -                       fsl_add_bridge(np, 0);
> -               else
> +               if ((rsrc.start & 0xfffff) == 0x8000)
>                         fsl_add_bridge(np, 1);
> +               else
> +                       fsl_add_bridge(np, 0);
Why this is needed?
For pcie@a000, fsl_add_bridge(np, 0)?
Roy
