Return-Path: <SRS0+c221ceb7dfe241bf38c8+1694+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6ADB7DDE00
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 22:53:07 +1000 (EST)
Subject: Re: [PATCH 1/8] [POWERPC] fsl_elbc_nand: factor out localbus defines
From: David Woodhouse <dwmw2@infradead.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C55A03A1-DDB4-4652-9758-2E78E38343B4@kernel.crashing.org>
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172328.GA7727@localhost.localdomain>
	<C55A03A1-DDB4-4652-9758-2E78E38343B4@kernel.crashing.org>
Content-Type: text/plain
Date: Sun, 13 Apr 2008 13:53:01 +0100
Message-Id: <1208091181.3026.103.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-04-11 at 09:06 -0500, Kumar Gala wrote:
> 
> David, can you ack this.  It looks good to me but want a MTD  
> maintainer ack before having it go through the powerpc tree.

Looks sane to me.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

-- 
dwmw2
