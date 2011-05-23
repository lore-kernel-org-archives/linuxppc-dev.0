Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1F82B6F5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 06:51:45 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc/book3e-64: reraise doorbell when masked by
	soft-irq-disable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110523152618.00a0e5f0@schlenkerla.am.freescale.net>
References: <20110520190047.GB7058@schlenkerla.am.freescale.net>
	<1305930778.7481.197.camel@pasglop>
	<20110523152618.00a0e5f0@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 May 2011 06:51:36 +1000
Message-ID: <1306183896.7481.209.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-05-23 at 15:26 -0500, Scott Wood wrote:
> On Sat, 21 May 2011 08:32:58 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Fri, 2011-05-20 at 14:00 -0500, Scott Wood wrote:
> > > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > > ---
> > >  arch/powerpc/kernel/exceptions-64e.S |   22 +++++++++++++++++++++-
> > >  1 files changed, 21 insertions(+), 1 deletions(-)
> > 
> > You can probably remove the doorbell re-check when enabling interrupts
> > now, can't you ?
> 
> Ah, so that's how it currently gets away without re-raising when the
> interrupt happens. :-)
> 
> I'll remove it.

Yup, I was too lazy to make a special case in the exception handlers :-)

Cheers,
Ben.
