Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BF3B5B7DA1
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 04:48:07 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o4HIm5E5017020
	for <linuxppc-dev@ozlabs.org>; Mon, 17 May 2010 11:48:05 -0700 (MST)
Subject: Re: [PATCH 1/3] powerpc/fsl: 85xx: document cache sram bindings
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1260257477-21942-1-git-send-email-vivek.mahajan@freescale.com>
Date: Mon, 17 May 2010 13:48:04 -0500
Message-Id: <A5DA1645-46C2-42DB-A7A9-7B72298F8E8F@freescale.com>
References: <1260257477-21942-1-git-send-email-vivek.mahajan@freescale.com>
To: Gupta Maneesh-B18878 <B18878@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 8, 2009, at 1:31 AM, Vivek Mahajan wrote:

> Adds binding documentation for cache sram for the PQ3 and
> some QorIQ based platforms.
>=20
> Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
> ---
> .../powerpc/dts-bindings/fsl/85xx_cache_sram.txt   |   20 =
++++++++++++++++++++
> 1 files changed, 20 insertions(+), 0 deletions(-)
> create mode 100644 =
Documentation/powerpc/dts-bindings/fsl/85xx_cache_sram.txt

This looks fine, I'm going to rename the file when I apply this patch =
since its applicable to more than 85xx.

- k=
