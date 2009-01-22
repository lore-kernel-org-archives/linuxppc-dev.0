Return-Path: <Haiying.Wang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62984DDF04
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 04:45:24 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0MHjLWB022611
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 10:45:22 -0700 (MST)
Received: from az33exm23.fsl.freescale.net (az33exm23.am.freescale.net
	[10.64.32.8])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n0MHjLcT024307
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 11:45:21 -0600 (CST)
Subject: Re: eth0: Could not attach to PHY
From: Haiying Wang <Haiying.Wang@freescale.com>
To: wael showair <showair2003@yahoo.com>
In-Reply-To: <21605367.post@talk.nabble.com>
References: <21589420.post@talk.nabble.com> <49783993.4090408@denx.de>
	<21605367.post@talk.nabble.com>
Content-Type: text/plain
Date: Thu, 22 Jan 2009 12:45:22 -0500
Message-Id: <1232646323.4661.3.camel@r54964-12.am.freescale.net>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-01-22 at 06:37 -0800, wael showair wrote:

> 		mdio@24520 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			device_type = "mdio";
> 			compatible = "gianfar";
> 			reg = <24520 20>;
> 			linux,phandle = <24520>;

Change compatible to "gianfar-mdio".

Haiying
