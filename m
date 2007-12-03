Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7AF55DDE46
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 07:53:03 +1100 (EST)
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrei Dolnikov <adolnikov@ru.mvista.com>
In-Reply-To: <20071129152836.GB13751@ru.mvista.com>
References: <20071129152836.GB13751@ru.mvista.com>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 07:52:50 +1100
Message-Id: <1196715170.13230.228.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 	#address-cells = <1>;
> +	#size-cells = <1>;
> +	model = "Katana-Qp"; /* Default */
> +	compatible = "emerson,Katana-Qp";
> +	coherency-off;
> +

What do that mean (coherency-off) ?

Somebody is trying again to use a 74xx with non cache coherent DMA ?
That isn't going to fly...

Ben.
 
