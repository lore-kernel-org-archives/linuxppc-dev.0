Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CF4BD2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jan 2005 04:13:58 +1100 (EST)
Date: Thu, 6 Jan 2005 09:13:55 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Andy Fleming <afleming@freescale.com>
Message-ID: <20050106171355.GB6539@gate.ebshome.net>
References: <FC6D9B81-5514-11D9-8D51-000393C30512@freescale.com>
	<A3A281FF-5525-11D9-80ED-000393C30512@freescale.com>
	<20050106070245.GA6539@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050106070245.GA6539@gate.ebshome.net>
Cc: Netdev <netdev@oss.sgi.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] Patch to Abstract Ethernet PHY support (using driver
	model)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 05, 2005 at 11:02:45PM -0800, Eugene Surovegin wrote:
> 5) PHY interrupt sharing looks broken. Although you request_irq using 
> SA_SHIRQ flag, in the handler itself you don't detect whether this 
> interrupt is for this PHY or not, and return IRQ_HANDLED. This will 
> result in first registered PHY hijacking IRQs from other PHYs (or 
> devices) sharing the same IRQ line.

Doh, ignore this. I wasn't thinking straight...

--
Eugene
