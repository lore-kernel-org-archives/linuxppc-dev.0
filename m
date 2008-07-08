Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A32DADDF5B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 10:46:17 +1000 (EST)
Subject: Re: [PATCH] ibm_newemac: Add MII mode support to the EMAC RGMII
	bridge.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <C497F939.104DB%gerickson@nuovations.com>
References: <C497F939.104DB%gerickson@nuovations.com>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 10:46:06 +1000
Message-Id: <1215477966.8970.181.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, jgarzik@pobox.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 16:47 -0700, Grant Erickson wrote:
> 
> Would you prefer?
> 
>     +#define RGMII_FER_MII(idx)     RGMII_FER_GMII(idx)
> 
> Having the "extra" mnemonic makes the code end up looking less like a typo
> and more like a conscious decision: "Yes, we know MII and GMII are the same
> setting, but we're being explicit about it."

Yeah, that looks better. Either that or a comment. 

Cheers,
Ben.
