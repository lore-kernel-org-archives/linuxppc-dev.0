Return-Path: <msm@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 0E4DA679E1
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 07:01:42 +1000 (EST)
Subject: Re: RFC: Location for Device Tree Sources?
From: Matthew McClintock <msm@freescale.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0608012258040.4041@poirot.grange>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 16:01:33 -0500
Message-Id: <1154466094.11069.6.camel@localhost>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-08-01 at 23:00 +0200, Guennadi Liakhovetski wrote:
> 
> Mark A. Greer in his patch to port sandpoint to arch/powerpc put 
> sandpoint.dts under arch/powerpc/boot/dts/sandpoint.dts 

I believe in his latest patches he removed this part. The device trees
were not included at all and he left this point open for discussion.

-Matthew
