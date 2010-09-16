Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id BCAA0B6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Sep 2010 06:11:20 +1000 (EST)
Received: by pwi4 with SMTP id 4so764933pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 13:11:18 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Thu, 16 Sep 2010 14:11:14 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] spi_mpc8xxx: fix writing to adress 0
Message-ID: <20100916201114.GA11972@angua.secretlab.ca>
References: <20100916070420.95083C7391@messagerie.si.c-s.fr>
	<OFE491C952.64B1BE24-ONC12577A0.0029DACE-C12577A0.002A0993@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFE491C952.64B1BE24-ONC12577A0.0029DACE-C12577A0.002A0993@transmode.se>
Cc: christophe leroy <christophe.leroy@c-s.fr>,
	spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 16, 2010 at 09:39:09AM +0200, Joakim Tjernlund wrote:
> > From: christophe leroy <christophe.leroy@c-s.fr>
> > To: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely
> > <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, linux-
> > kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
> > Date: 2010/09/16 09:06
> > Subject: [PATCH] spi_mpc8xxx: fix writing to adress 0
> > Sent by: linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org
> >
> > This patch applies to 2.6.34.7 (already included in 2.6.35.4)
> > It fixes an issue when sending only or receiving only (mspi->tx-dma was reset
> > as when no tx_buf is defined, tx_dma is 0)
> >
> > Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>
> 
> Acked-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> 

You need to send this to the linux-stable list and include the sha1
commit id that fixes it in mainline.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.
