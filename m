Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 669A0DDEE4
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 05:00:07 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0MI027l026946
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 11:00:03 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n0MI02mF000571
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 12:00:02 -0600 (CST)
Date: Thu, 22 Jan 2009 12:00:01 -0600
From: Scott Wood <scottwood@freescale.com>
To: Haiying Wang <Haiying.Wang@freescale.com>
Subject: Re: eth0: Could not attach to PHY
Message-ID: <20090122180001.GB18427@ld0162-tx32.am.freescale.net>
References: <21589420.post@talk.nabble.com> <49783993.4090408@denx.de>
	<21605367.post@talk.nabble.com>
	<1232646323.4661.3.camel@r54964-12.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1232646323.4661.3.camel@r54964-12.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, wael showair <showair2003@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 22, 2009 at 12:45:22PM -0500, Haiying Wang wrote:
> On Thu, 2009-01-22 at 06:37 -0800, wael showair wrote:
> 
> > 		mdio@24520 {
> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> > 			device_type = "mdio";
> > 			compatible = "gianfar";
> > 			reg = <24520 20>;
> > 			linux,phandle = <24520>;
> 
> Change compatible to "gianfar-mdio".

"fsl,gianfar-mdio"

-Scott
