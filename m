Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F215ADDEC6
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 17:55:19 +1000 (EST)
Subject: Re: modpost warning question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0707250210520.14366@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0707250210520.14366@blarg.am.freescale.net>
Content-Type: text/plain
Date: Wed, 25 Jul 2007 17:55:03 +1000
Message-Id: <1185350103.5439.314.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sam@ravnborg.org, linux-kernel@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-25 at 02:14 -0500, Kumar Gala wrote:
> I'm seeing the following warning:
> 
> WARNING: vmlinux.o(.init.text+0x1acdc): Section mismatch: reference to
> .exit.text:gfar_mdio_exit (between 'gfar_init' and 'gfar_mdio_init')
> 
> I don't understand why its not ok to access .exit.text from .init.text
> 
> The following addresses the issue, however I don't particularly like it:

Because exit.text is removed when compiling built-in

Ben.
