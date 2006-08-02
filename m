Return-Path: <bcook@bpointsys.com>
Received: from bpointsys.com (70-253-197-251.ded.swbell.net [70.253.197.251])
	by ozlabs.org (Postfix) with ESMTP id C946867C21
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 04:54:07 +1000 (EST)
From: Brent Cook <bcook@bpointsys.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: RFC: Location for Device Tree Sources?
Date: Wed, 2 Aug 2006 13:41:51 -0500
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<20060802182226.GH17652@mag.az.mvista.com>
In-Reply-To: <20060802182226.GH17652@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608021341.52084.bcook@bpointsys.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 02 August 2006 13:22, Mark A. Greer wrote:
>
> Well, if you're going to keep prebuilt dtb files there, why wouldn't you
> want the dts that makes that dtb to be in the same place?
>
> Mark

There is precedence for this. Look at drivers/net/ixp2000/, it includes both 
the microengine source code, and the precompiled binary blob files (in case 
you do not have the required assembler.)

 - Brent
