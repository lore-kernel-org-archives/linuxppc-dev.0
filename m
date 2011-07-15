Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81104B6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Jul 2011 06:08:06 +1000 (EST)
Received: by pvg18 with SMTP id 18so1639802pvg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 13:08:03 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 15 Jul 2011 14:08:01 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc/5200: add GPIO functions for simple interrupt
	GPIOs
Message-ID: <20110715200801.GJ2833@ponder.secretlab.ca>
References: <1306142730-7528-1-git-send-email-agust@denx.de>
	<20110706175245.GL5805@ponder.secretlab.ca>
	<20110709121409.4ee9249e@wker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110709121409.4ee9249e@wker>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 09, 2011 at 12:14:09PM +0200, Anatolij Gustschin wrote:
> On Wed, 6 Jul 2011 11:52:45 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
> 
> > On Mon, May 23, 2011 at 11:25:30AM +0200, Anatolij Gustschin wrote:
> > > The mpc52xx_gpio driver currently supports 8 wakeup GPIOs and 32
> > > simple GPIOs. Extend it to also support GPIO function of 8 simple
> > > interrupt GPIOs controlled in the standard GPIO register module.
> > > 
> > > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > > ---
> > >  arch/powerpc/platforms/52xx/mpc52xx_gpio.c |  117 ++++++++++++++++++++++++++++
> > 
> > I don't want to merge more open coded MMIO gpio driver code.  This whole driver really needs to be converted to use GENERIC_GPIO.
> 
> I'm not sure I understand what you mean. Do you mean
> the conversion to drop of_mm_* stuff?

No, I mean conversion to use the generic gpio register access
functions instead of creating new ones.

g.
