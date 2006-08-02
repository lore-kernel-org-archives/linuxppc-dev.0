Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C7B7B67C43
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 04:29:52 +1000 (EST)
Subject: Re: RFC: Location for Device Tree Sources?
From: Jon Loeliger <jdl@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060802182226.GH17652@mag.az.mvista.com>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
	<20060802003504.GA20439@mag.az.mvista.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<20060802182226.GH17652@mag.az.mvista.com>
Content-Type: text/plain
Message-Id: <1154543116.19994.39.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 02 Aug 2006 13:25:16 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-02 at 13:22, Mark A. Greer wrote:

> 
> Well, if you're going to keep prebuilt dtb files there, why wouldn't you
> want the dts that makes that dtb to be in the same place?

I don't think we should keep pre-compiled DTB files
around anywhere.  We don't keep a bunch of derived .o
files around, do we?

jdl
