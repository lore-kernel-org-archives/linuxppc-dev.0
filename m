Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 623CADE036
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 01:54:18 +1000 (EST)
Date: Thu, 19 Jul 2007 10:52:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 03/12] Consolidate of_device_is_compatible
Message-ID: <20070719155207.GA28617@ld0162-tx32.am.freescale.net>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720011012.4eca281d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070720011012.4eca281d.sfr@canb.auug.org.au>
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>,
	paulus@samba.org, "David S. Miller" <davem@davemloft.net>,
	wli@holomorphy.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 20, 2007 at 01:10:12AM +1000, Stephen Rothwell wrote:
> The only difference here is that Sparc uses strncmp to match compatibility
> names while PowerPC uses strncasecmp.

Could we put a comment in saying that both should really just use
strcmp(), and that this mechanism should go away once any compatibility
issues are found and addressed?

The PowerPC one will need to drop the 'n' soon, as well, but that should
be a separate patch.

-Scott
