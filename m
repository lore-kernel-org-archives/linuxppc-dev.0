Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id E9738679E7
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 06:59:54 +1000 (EST)
Date: Tue, 1 Aug 2006 23:00:12 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: RFC: Location for Device Tree Sources?
In-Reply-To: <1154464346.19994.4.camel@cashmere.sps.mot.com>
Message-ID: <Pine.LNX.4.60.0608012258040.4041@poirot.grange>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 1 Aug 2006, Jon Loeliger wrote:

> Folks,
> 
> Where should we place the sources for the OF Flat Device
> Tree source files?  They used to be in U-Boot, but that
> isn't happening any more.
> 
> One semi-obvious place would be to co-locate them with
> their corresponding Linux arch/powerpc/platform directory.
> Another would be to have a new directory full of them
> under, say, arch/powerpc/devtrees or so.
> 
> Are there other suggestions or better ideas?

Mark A. Greer in his patch to port sandpoint to arch/powerpc put 
sandpoint.dts under arch/powerpc/boot/dts/sandpoint.dts

Thanks
Guennadi
---
Guennadi Liakhovetski
