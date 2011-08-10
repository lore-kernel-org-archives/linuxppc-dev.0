Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay3.sgi.com [192.48.152.1])
	by ozlabs.org (Postfix) with ESMTP id 941E6B71A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 20:15:38 +1000 (EST)
Date: Wed, 10 Aug 2011 05:15:36 -0500
From: Robin Holt <holt@sgi.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v10 4/5] [powerpc] Add flexcan device support for p1010rdb.
Message-ID: <20110810101535.GO4926@sgi.com>
References: <1312945564-6626-1-git-send-email-holt@sgi.com>
	<1312945564-6626-5-git-send-email-holt@sgi.com>
	<4E4255B1.6050001@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E4255B1.6050001@pengutronix.de>
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2011 at 11:56:01AM +0200, Marc Kleine-Budde wrote:
> On 08/10/2011 05:06 AM, Robin Holt wrote:
> > diff --git a/arch/powerpc/platforms/85xx/clock.c b/arch/powerpc/platforms/85xx/clock.c
> > new file mode 100644
> > index 0000000..16fae04
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/85xx/clock.c
> > @@ -0,0 +1,53 @@
...
> > +void __init mpc85xx_clk_init(void)
> > +{
> > +	clk_functions = mpc85xx_clk_functions;
> > +}
> > +
> 
> git is even picker then me: "new blank line at EOF."
> please fix

That reminded me that I have slacked on using checkpatch.pl in a few
resends and it really does not like this patch at all so I will rework
the patch with its concerns.  I am going to hold off on resending until
there are more substantial changes.

Thanks,
Robin
