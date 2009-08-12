Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 53751B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 19:56:59 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9AEE3DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 19:56:57 +1000 (EST)
Subject: Re: Problem with PCIe -> PCI bridge on MPC8377E-RDB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <705D9914-7AC7-42AB-A7F9-AD2447B9DDD8@kernel.crashing.org>
References: <4D3BDC67-986A-482D-BB3F-497F64C68531@mhlabs.com>
	<9E566D12-1A26-41BC-BB71-27D4CCE54E20@kernel.crashing.org>
	<2D2EDFA8-E51F-4A2D-BEB7-8F9258518DA1@mhlabs.com>
	<705D9914-7AC7-42AB-A7F9-AD2447B9DDD8@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 12 Aug 2009 19:56:47 +1000
Message-Id: <1250071007.3587.2.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "B.J. Buchalter" <bj@mhlabs.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-12 at 00:20 -0500, Kumar Gala wrote:
> It is suppose to.  I would recommend updating u-boot to something  
> newer and see what you get on that side.
> 
> Also I'll try see if we have a PCIe board w/a p2p bridge on it.  I'm  
> guessing no one has tried PCIe on 83xx w/a p2p bridge on it.

A few off-the-shelves FW + USB2 PCIe cards have that bridge and have
shown weird issues, might be worth shopping at your local Fry's :-)

Cheers,
Ben.
