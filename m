Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EE0BEB6F82
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jun 2011 08:16:55 +1000 (EST)
Received: by pzk26 with SMTP id 26so479323pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 08 Jun 2011 15:16:52 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 8 Jun 2011 16:16:51 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] powerpc: dtc: remove obsolete .gitignore entries
Message-ID: <20110608221651.GC17138@ponder.secretlab.ca>
References: <1299948250-32084-1-git-send-email-w.sang@pengutronix.de>
	<20110331155834.GE26709@ponder.secretlab.ca>
	<20110608204947.GG21996@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110608204947.GG21996@pengutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 08, 2011 at 10:49:47PM +0200, Wolfram Sang wrote:
> On Thu, Mar 31, 2011 at 09:58:34AM -0600, Grant Likely wrote:
> > On Sat, Mar 12, 2011 at 05:44:10PM +0100, Wolfram Sang wrote:
> > > dtc was moved and .gitignores have been added to the new location. So, we can
> > > delete the old, forgotten ones.
> > > 
> > > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > It's Ben's jurisdiction, but I've picked it up into my
> > devicetree/merge branch anyway.  If I don't hear from Ben either way
> > then I'll push it out to Linus next week.
> 
> I can't find it there?

Arg, I lost it.  I just pushed it out to devicetree/next

g.
