Return-Path: <khali@linux-fr.org>
Received: from poutre.nerim.net (poutre.nerim.net [62.4.16.124])
	by ozlabs.org (Postfix) with ESMTP id 16294B7D4B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 19:40:45 +1100 (EST)
Date: Fri, 12 Mar 2010 09:26:19 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 33/37] sound/soc: use .dev.of_node instead of .node in
	struct of_device
Message-ID: <20100312092619.6a6f5e20@hyperion.delvare>
In-Reply-To: <fa686aa41003111322wc1f15b2hd3f653af060f56bf@mail.gmail.com>
References: <20100311174830.4824.19820.stgit@angua>
	<20100311180649.4824.10368.stgit@angua>
	<20100311193458.GA13289@opensource.wolfsonmicro.com>
	<fa686aa41003111322wc1f15b2hd3f653af060f56bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-ide@vger.kernel.org, James.Bottomley@suse.de,
	linux-i2c@vger.kernel.org, sparclinux@vger.kernel.org,
	jeremy.kerr@canonical.com, sfr@canb.auug.org.au,
	linux-scsi@vger.kernel.org, jgarzik@pobox.com,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, ben-linux@fluff.org,
	timur@freescale.com, lrg@slimlogic.co.uk, monstr@monstr.eu,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, gregkh@suse.de,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	dwmw2@infradead.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 11 Mar 2010 14:22:37 -0700, Grant Likely wrote:
> On Thu, Mar 11, 2010 at 12:34 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Thu, Mar 11, 2010 at 11:06:50AM -0700, Grant Likely wrote:
> >> .node is being removed
> >>
> >> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> >
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> >
> > but please ensure that Liam and especially Timur also check this (both
> > CCed).
> >
> > For enormous patch serieses like this it's really nice if you can ensure
> > that each person is only CCed on the patches that they need to review.
> > Much less stuff in the inbox.
> 
> Yeah, sorry about that (and to everyone receiving this thread, I'm
> really sorry.  I won't do it again).  I've already been yelled at for
> that.  What happened is that on a previous series I was yelled at for
> not sending all patches to everyone (so that the patches could be
> reviewed in context).  So, naturally, I made sure to include everyone
> on the whole series this time....  doh.
> 
> Next time I post I'll constrain it to small chunks.

A good compromise IMHO is to send only the pieces they really have to
see and ack to each person, and provide a pointer to somewhere the full
series can be seen and downloaded for the interested.

-- 
Jean Delvare
