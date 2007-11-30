Return-Path: <SRS0+1715c8100ed1f66bc9a4+1559+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A509DDDECC
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 18:56:52 +1100 (EST)
Date: Fri, 30 Nov 2007 07:56:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/11] ibm_newemac: Add BCM5248 and Marvell 88E1111 PHY
	support
Message-ID: <20071130075641.GA16650@infradead.org>
References: <1196401223.5661.297518056501.qpush@grosgo>
	<20071130054126.39BDCDDE0A@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071130054126.39BDCDDE0A@ozlabs.org>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 30, 2007 at 04:40:23PM +1100, Benjamin Herrenschmidt wrote:
> From: Stefan Roese <sr@denx.de>
> 
> This patch adds BCM5248 and Marvell 88E1111 PHY support to NEW EMAC driver.
> These PHY chips are used on PowerPC 440EPx boards.
> The PHY code is based on the previous work by Stefan Roese <sr@denx.de>

Is there a reason the emac driver isn't using the generic phy code?
