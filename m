Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc: Add support for AMCC Taishan 440GX eval board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200702121129.05004.sr@denx.de>
References: <200702121129.05004.sr@denx.de>
Content-Type: text/plain
Date: Mon, 12 Feb 2007 23:06:28 +1100
Message-Id: <1171281988.20192.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-12 at 11:29 +0100, Stefan Roese wrote:
> [PATCH] ppc: Add support for AMCC Taishan 440GX eval board
> 
> This patch adds support for the AMCC Taishan PPC440GX evaluation
> board.
> 
> This is still an arch/ppc port. I'm aware that the move
> 4xx -> arch/powerpc is making good progress right now. So this
> patch is mainly intended to make the Taishan support available
> for the community right now.

Excellent, thanks.

David Gibson is making some good progress with the powerpc port, we have
ebony booting and emac's up, though he's still ironing out some issues
and PCI is still to go. Hopefully, we'll port Taishan next as I really
want to have a 440GX in asap.

Cheers,
Ben.
