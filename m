Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3601767B68
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 09:11:24 +1000 (EST)
Subject: Re: [PATCH] Prevent legacy io access on pmac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20060911151730.GA25244@aepfle.de>
References: <20060911115354.GA23884@aepfle.de>
	<20060911151730.GA25244@aepfle.de>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 09:11:09 +1000
Message-Id: <1158016269.15465.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-09-11 at 17:17 +0200, Olaf Hering wrote:
> On Mon, Sep 11, Olaf Hering wrote:
> 
> > * add check for parport_pc, exit on pmac.
> 
> How do I allow parport on PCI cards?

Doesn't the driver have explicit PCI probing like 8250 ?

Ben.
