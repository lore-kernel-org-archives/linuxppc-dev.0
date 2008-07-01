Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82F9DDDF2C
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 09:52:56 +1000 (EST)
Subject: Re: [PATCH v2] Parameterize EMAC Multicast Match Handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <C48FC1C4.10254%gerickson@nuovations.com>
References: <C48FC1C4.10254%gerickson@nuovations.com>
Content-Type: text/plain
Date: Wed, 02 Jul 2008 09:52:45 +1000
Message-Id: <1214956365.20711.200.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-01 at 11:13 -0700, Grant Erickson wrote:

> In terms of the device tree expression, you would both favor something akin
> to the following?
> 
> -              compatible = "ibm,emac-405exr", "ibm,emac4";
> +              compatible = "ibm,emac-405exr", "ibm,emac4", "ibm,emac4sync";

leave ibm,emac4 either at the end or totally out

Cheers,
Ben.
