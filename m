Return-Path: <Tony.Li@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 30F26DDE22
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 12:52:15 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	lB41q9UV007298
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 18:52:10 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lB41q7hf020099
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 19:52:08 -0600 (CST)
Subject: Re: [PATCH] Add IPIC MSI interrupt support
From: Li Li <r64360@freescale.com>
To: benh@kernel.crashing.org
In-Reply-To: <1196715812.13230.234.camel@pasglop>
References: <1196394519.29683.8.camel@Guyver>
	<1196654521.13554.32.camel@concordia>
	<1196672870.14353.21.camel@Guyver>
	<1196715812.13230.234.camel@pasglop>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 09:41:50 +0800
Message-Id: <1196732510.2910.3.camel@Guyver>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Gala Kumar <kumar.gala@freescale.com>, Li Tony <Tony.Li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-12-04 at 05:03 +0800, Benjamin Herrenschmidt wrote:
> 
> On Mon, 2007-12-03 at 17:07 +0800, Li Li wrote: 
> > 
> > In IPIC, the 8 MSI interrupts is handled as level intrrupt. 
> > I just provide a versatile in case it is changed.
> 
> Level ? Are you sure ? MSIs are by definition edge interrupts... Or
> do 
> you have some weird logic that asserts a level input until you go ack 
> something ? Sounds weird...
> 

The second one.
The MSI is edge interrupt. The 256 MSI interrupts are divided into 8
groups. Each group can generate a interrupt to core. This interrupts are
level and asserted untile ack MSI interrupt. A little weird.

> Ben.
> 
> 

- Tony
