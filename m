Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 103A568525
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2005 04:22:32 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 12 Oct 2005 11:22:29 -0700
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20051012182229.GA22838@xyzzy.farnsworth.org>
References: <20050914091229.A27721C007F7@mwinf0309.wanadoo.fr>
	<20051011135022.60ddfbbc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051011135022.60ddfbbc.akpm@osdl.org>
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, dholm@gentoo.org,
	det.nicolas@free.fr
Subject: Re: SRAM support for the Pegasos II platform
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 11, 2005 at 08:50:22PM +0000, Andrew Morton wrote:
> Nicolas DET <det.nicolas@free.fr> wrote:
> >
> > You can find enclosed or at the URL a patch for the 2.6.14-rc1.
> > http://arrakin.homedns.org/~nicolas/mv643xx_eth_chrp_pegasos_eth.c.2.6.14-rc1.diff
> > 
> > It allows (with drivers/net/mv643xx_eth.*) to take advantage of the SRAM of
> > the Marvell Discovery II for the network driver.
> 
> I've kind of lost the plot with what happened with this patch.  Who is the
> maintainer of this driver, and has [s]he commented on this patch?

I'm the maintainer of the 2.6 mv643xx_eth driver.  The only comment I had
(in http://ozlabs.org/pipermail/linuxppc-dev/2005-September/019764.html)
was that the define for PEGASOS2_SRAM_SIZE looks wrong.  When that and
the whitespace/style issues are fixed, I'm OK with the change.

-Dale
