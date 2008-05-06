Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B3D28DDF0B
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 08:03:33 +1000 (EST)
Message-ID: <4820D5E5.9030509@freescale.com>
Date: Tue, 06 May 2008 17:04:21 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ronald Madrid <ron_madrid@hotmail.com>
Subject: Re: ifconfig MPC8313
References: <BAY114-W949ADEBC809E7A60716CCF4D60@phx.gbl>
	<4820CB5D.3000703@freescale.com>
	<BAY114-W46AEF8E266395E333E7FCF4D60@phx.gbl>
	<4820CF2A.5040301@freescale.com>
	<BAY114-W4066C5694CA67654680FB7F4D60@phx.gbl>
	<4820D11D.1050005@freescale.com>
	<BAY114-W13CCF7FDD3C01260AC40A9F4D60@phx.gbl>
In-Reply-To: <BAY114-W13CCF7FDD3C01260AC40A9F4D60@phx.gbl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ronald Madrid wrote:
> I believe that it is zero.  Is that valid?

FWIH, it's not recommended, as it's interpreted as a broadcast address 
in some cases.  However, if that's the way the board is, then go ahead 
and put a zero in the phy node's reg property.

-Scott
