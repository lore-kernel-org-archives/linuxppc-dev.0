Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7EA86B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 20:35:03 +1100 (EST)
Subject: RE: gianfar breaking builds
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gopalpet-B05799 <B05799@freescale.com>
In-Reply-To: <9F4C7D19E8361D4C94921B95BE08B81BA08A6F@zin33exm22.fsl.freescale.net>
References: <1260341804.16132.22.camel@pasglop>
	<9F4C7D19E8361D4C94921B95BE08B81BA08A66@zin33exm22.fsl.freescale.net>
	<1260350780.16132.40.camel@pasglop>
	<9F4C7D19E8361D4C94921B95BE08B81BA08A6F@zin33exm22.fsl.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Dec 2009 20:34:56 +1100
Message-ID: <1260351296.16132.42.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-12-09 at 15:02 +0530, Kumar Gopalpet-B05799 wrote:
> 
> I din't notice that netpoll wa enabled in your compilation.
> This is also not wotking on net-next tree.
> 
> Will send out a patch today in some time.

Ah yes, this is something close to a 6xx_defconfig. Thanks.

Cheers,
Ben.
