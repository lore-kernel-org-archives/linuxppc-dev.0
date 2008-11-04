Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5DBFDE005
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 08:30:13 +1100 (EST)
Subject: Re: Connecting to "PCI command write" interrupt on 4xx platforms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
In-Reply-To: <200811041217.04961.matthias.fuchs@esd-electronics.com>
References: <200810301158.46686.matthias.fuchs@esd-electronics.com>
	<200811040619.13820.sr@denx.de> <1225779403.8004.263.camel@pasglop>
	<200811041217.04961.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain
Date: Wed, 05 Nov 2008 08:29:44 +1100
Message-Id: <1225834184.8004.268.camel@pasglop>
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

On Tue, 2008-11-04 at 12:17 +0100, Matthias Fuchs wrote:
> I must admit that I am not sure what you mean by (pci-endpoint)
> _name_.
> Do you mean something like this:
>  
>         PCI: pci@abc {
>                 endpoint = "pci-endpoint";
>                 ...
> 
> To many "endpoint" appearances for my taste:-)

No, by name I meant

	PCI: pci-endpoint@xxxx {
	}

But if we want to have the same device node easily convert between
endpoint and host, maybe simply a property would be enough. Either just
an empty "endoint" property or a "mode" property containing "endpoint"
 vs. "host".

I tend to prefer changing the name if we aren't going to be a host
bridge though.

Ben.
