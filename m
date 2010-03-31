Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 34A6DB7CF8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Apr 2010 02:48:28 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o2VFmPAx011980 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Mar 2010 08:48:25 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o2VFuxlx013475
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Mar 2010 10:57:00 -0500 (CDT)
Message-ID: <4BB36EB1.6010105@freescale.com>
Date: Wed, 31 Mar 2010 10:48:01 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Peter Pan <pppeterpppan@gmail.com>
Subject: Re: I can not get my MII working on MPC8247 with Linux 2.6.32.6
References: <48abf2c21003301846h67106ce6h8d51ad167374793f@mail.gmail.com>
In-Reply-To: <48abf2c21003301846h67106ce6h8d51ad167374793f@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Pan wrote:
> Recently, I'm porting Linux 2.6.32.6 to our customized MPC8247 based
> board. Everything is fine out except my ethernets. I uses
> cpm2-scc-enet and cpm2-fcc-enet drivers.
> My ethernet works fine in U-Boot with the same setting, and our
> previous Linux 2.6.22 is also working, so there should be nothing
> wrong with the hardware.
> The boot log of the MII part is:
> 
> CPM2 Bitbanged MII: probed
> mdio_bus f0010d00: error probing PHY at address 0
> mdio_bus f0010d00: error probing PHY at address 1

Are 0 and 1 the addresses you're expecting the PHYs to be at?

If that's not it, I'd try to examine the specific register accesses that 
2.6.22 is doing and see what's different.

-Scott
