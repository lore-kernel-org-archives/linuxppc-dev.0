Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by ozlabs.org (Postfix) with ESMTP id 7A464DDED8
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 16:30:55 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4147752wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 23:30:54 -0700 (PDT)
Date: Sat, 12 Jul 2008 00:30:51 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Message-ID: <20080712063051.GD23213@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807070932q108da172n117c0670238db8a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807070932q108da172n117c0670238db8a5@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, timur@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 07, 2008 at 12:32:29PM -0400, Jon Smirl wrote:
> On 7/1/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> >  This is an I2S bus driver for the MPC5200 PSC device.  It is probably
> >  will not be merged as-is because it uses v1 of the ASoC API, but I want
> >  to get it out there for comments.
> >  ---
> We need to tie the two PSCs up like this to get the audio clock in via
> PSC1 and then have PSC2 generate the frame clock when the i2s data is
> transmitted.
> 
> Do you want a diff, or do you have a new version with DMA broken out?

You may as well send me the diff.  I can't promise that I'll actually
get it merged in, but I'll try.

g.
