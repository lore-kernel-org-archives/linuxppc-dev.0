Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id 876ADDDEAB
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jan 2008 08:48:11 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2841137pyg.27
	for <linuxppc-dev@ozlabs.org>; Sat, 05 Jan 2008 13:48:11 -0800 (PST)
Date: Sat, 5 Jan 2008 15:48:05 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] ibm_newemac: Increase number of default rx-/tx-buffers
Message-ID: <20080105154805.118eb3d1@vader.jdub.homelinux.org>
In-Reply-To: <1199566386.7291.58.camel@pasglop>
References: <1199526609-12290-1-git-send-email-sr@denx.de>
	<1199528388.7291.55.camel@pasglop> <200801051338.17957.sr@denx.de>
	<1199566386.7291.58.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 06 Jan 2008 07:53:06 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Sat, 2008-01-05 at 13:38 +0100, Stefan Roese wrote:
> > On Saturday 05 January 2008, Benjamin Herrenschmidt wrote:
> > > On Sat, 2008-01-05 at 10:50 +0100, Stefan Roese wrote:
> > > > Performance tests done by AMCC have shown that 256 buffer increase the
> > > > performance of the Linux EMAC driver. So let's update the default
> > > > values to match this setup.
> > > >
> > > > Signed-off-by: Stefan Roese <sr@denx.de>
> > > > ---
> > >
> > > Do we have the numbers ? Did they also measure latency ?
> > 
> > I hoped this question would not come. ;) No, unfortunately I don't have any 
> > numbers. Just the recommendation from AMCC to always use 256 buffers.
> 
> Ok. Well, it's just a .config option so I suppose the patch is fine. Can
> you also update the defconfigs (at least for the recent AMCC boards) ?

No need for a defconfig update patch.  Paul or I usually do a general
defconfig update for most boards before the next kernel version.  This
will get picked up then.

josh
