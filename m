Return-Path: <SRS0+703ff539752438bf2049+1557+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: Re: [PATCH] Fix buglets in mpc5200 FEC code that are corrupting
	memory.
From: David Woodhouse <dwmw2@infradead.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910711181749p1d2744b1md8ea92fdca60d6d6@mail.gmail.com>
References: <9e4733910711082131v70c4b7bm2b00445b7e62c33f@mail.gmail.com>
	<20071109091245.GA3148@nd47.coderock.org>
	<fa686aa40711090557u1b6cb29ex388b82efcbad7c18@mail.gmail.com>
	<9e4733910711181749p1d2744b1md8ea92fdca60d6d6@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 28 Nov 2007 18:04:10 +0000
Message-Id: <1196273051.30806.44.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>, Jeff Garzik <jgarzik@pobox.com>,
	Domen Puncer <domen.puncer@telargo.com>, netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-11-18 at 20:49 -0500, Jon Smirl wrote:
> On 11/9/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On 11/9/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> > > On 09/11/07 00:31 -0500, Jon Smirl wrote:
> > > > This is the reason I couldn't get user space started or connect to my
> > > > nfs server. Patch is against current linus git.
> > > >
> > > > mpc5200 fec driver is corrupting memory. This patch fixes two bugs
> > > > where the wrong skb buffer was being referenced.
> > > >
> > > > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> > >
> > > Acked-by: Domen Puncer <domen.puncer@telargo.com>
> >
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> >
> > Jeff, can you please pick this up for .24?
> 
> This is didn't make it into rc3. Without this patch this driver is broken.

Jeff?

-- 
dwmw2
