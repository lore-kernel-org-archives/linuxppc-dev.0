Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D623867A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 14:54:53 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050308194229.41c23707.davem@davemloft.net>
References: <1107b64b01fb8e9a6c84359bb56881a6@freescale.com>
	<1110334456.32556.21.camel@gaston>
	<20050308194229.41c23707.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 14:50:14 +1100
Message-Id: <1110340214.32524.32.camel@gaston>
Mime-Version: 1.0
Cc: netdev@oss.sgi.com, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: PHY Abstraction Layer II
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2005-03-08 at 19:42 -0800, David S. Miller wrote:
> On Wed, 09 Mar 2005 13:14:16 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > I'll have a closer look when I find some time, see if it makes sense to
> > adapt sungem or not.
> 
> Especially because of the Broadcom PHYs I bet it doesn't.
> 
> Too many chips have to reset the MAC, or do other fancy stuff
> when programming the PHY to make this genphy thing very useful.

Oh, I think genphy is just a generic driver, but his layer has hooks for
other PHY drivers (wasn't it based on sungem_phy in the first place ?)

I discussed several steps of the design with Andy, the idea was to have
something a bit like sungem_phy.c with addditional common library for
doing the link polling & fallback stuff etc... that could be easily
shared by drivers.

Ben.
