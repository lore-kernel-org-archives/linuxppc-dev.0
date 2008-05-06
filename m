Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2C26BDDF04
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 07:34:50 +1000 (EST)
Message-ID: <4820CF2A.5040301@freescale.com>
Date: Tue, 06 May 2008 16:35:38 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ronald Madrid <ron_madrid@hotmail.com>
Subject: Re: ifconfig MPC8313
References: <BAY114-W949ADEBC809E7A60716CCF4D60@phx.gbl>
	<4820CB5D.3000703@freescale.com>
	<BAY114-W46AEF8E266395E333E7FCF4D60@phx.gbl>
In-Reply-To: <BAY114-W46AEF8E266395E333E7FCF4D60@phx.gbl>
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
> I'm guessing by device tree you mean the .dts file?  I'm using a 
> modified version of the mpc8313erdb.dts with minor changes (to the local 
> bus only).  Here is a copy of it.

OK, according to that device tree, eth0 is associated with PHY address 
1.  Is that correct on your board?

-Scott
