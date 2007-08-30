Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DF251DDE26
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 15:56:53 +1000 (EST)
Date: Thu, 30 Aug 2007 00:56:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 8/9] mpc82xx: Update mpc8272ads,
	and factor out PCI and reset.
Message-ID: <20070830055644.GA21604@ld0162-tx32.am.freescale.net>
References: <20070828201929.GH24329@ld0162-tx32.am.freescale.net>
	<66A3DBEB-412D-4229-88DA-B47F3256CEF6@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <66A3DBEB-412D-4229-88DA-B47F3256CEF6@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2007 at 05:41:17PM -0500, Kumar Gala wrote:
> NACK.
> 
> I don't want pq2 to be the only platform that has the PCI bus  
> separate from the PCI controller.

Could you articulate the reasons why you'd rather have a mishmash of crap
in the soc node's ranges property?

-Scott
