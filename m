Return-Path: <glikely@secretlab.ca>
Received: from mail-px0-f171.google.com (mail-px0-f171.google.com
	[209.85.212.171]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B7B161007F0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 May 2011 08:31:27 +1000 (EST)
Received: by pxi7 with SMTP id 7so3002655pxi.16
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 02 May 2011 15:31:25 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Mon, 2 May 2011 16:31:20 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v6 6/6] powerpc, tqm5200: update tqm5200_defconfig to fit
	for charon board.
Message-ID: <20110502223120.GD15187@ponder.secretlab.ca>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1300782452-528-1-git-send-email-hs@denx.de>
	<1300782452-528-7-git-send-email-hs@denx.de>
	<20110322091027.GC2134@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110322091027.GC2134@pengutronix.de>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Samuel Ortiz <sameo@linux.intel.com>, Vincent Sanders <vince@simtec.co.uk>,
	linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Paul Mundt <lethal@linux-sh.org>, Heiko Schocher <hs@denx.de>,
	linuxppc-dev@lists.ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 22, 2011 at 10:10:27AM +0100, Wolfram Sang wrote:
> >     As this board is tqm5200 based, added necessary changes
> >     to the tqm5200_defconfig. In previous patchserie I added
> >     the changes to mpc5200_defconfig, as Wolfram Sang mentioned,
> >     but as tqm5200_defconfig is in mainline, and the board is
> >     tqm5200 based, I think, thats the appropriate place, as
> 
> I'd think the perfect solution would have been to merge the
> tqm-defconfig into the mpc5200-defconfig entirely and get rid of it.
> That being said, I don't think this issue is big enough to block this
> series, so fine enough with me.

Merged, thanks.

g.
