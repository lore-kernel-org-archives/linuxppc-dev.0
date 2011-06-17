Return-Path: <B07421@freescale.com>
Received: from CH1EHSOBE004.bigfish.com (ch1ehsobe004.messaging.microsoft.com
	[216.32.181.184]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 202BEB6FD2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jun 2011 02:11:08 +1000 (EST)
Date: Fri, 17 Jun 2011 11:02:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/book3e-64: reraise doorbell when masked by
	soft-irq-disable
Message-ID: <20110617110255.00d26526@schlenkerla.am.freescale.net>
In-Reply-To: <1308287520.32158.14.camel@pasglop>
References: <20110520190047.GB7058@schlenkerla.am.freescale.net>
	<1305930778.7481.197.camel@pasglop>
	<20110523152618.00a0e5f0@schlenkerla.am.freescale.net>
	<1306183896.7481.209.camel@pasglop>
	<1308287520.32158.14.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 17 Jun 2011 15:12:00 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2011-05-24 at 06:51 +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2011-05-23 at 15:26 -0500, Scott Wood wrote:
> > > On Sat, 21 May 2011 08:32:58 +1000
> > > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > 
> > > > On Fri, 2011-05-20 at 14:00 -0500, Scott Wood wrote:
> > > > > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > > > > ---
> > > > >  arch/powerpc/kernel/exceptions-64e.S |   22 +++++++++++++++++++++-
> > > > >  1 files changed, 21 insertions(+), 1 deletions(-)
> > > > 
> > > > You can probably remove the doorbell re-check when enabling interrupts
> > > > now, can't you ?
> > > 
> > > Ah, so that's how it currently gets away without re-raising when the
> > > interrupt happens. :-)
> > > 
> > > I'll remove it.
> > 
> > Yup, I was too lazy to make a special case in the exception handlers :-)
> 
> Are you going to send a re-spin ?

Ah, yes, forgot about this one. :-)

-Scott
