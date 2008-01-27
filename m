Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id D55B5DDE00
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 00:43:17 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so323158anc.78
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 05:43:15 -0800 (PST)
Date: Sun, 27 Jan 2008 07:42:30 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 00/11] ps3av/3fb patches for 2.6.25
Message-ID: <20080127074230.00adf79d@zod.rchland.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0801271215120.10514@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
	<20080126220139.5385f2c7.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0801271041160.10193@vixen.sonytel.be>
	<20080127021659.fb6c72a1.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0801271215120.10514@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Antonino Daplas <adaplas@gmail.com>, Cell,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Development <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 27 Jan 2008 12:15:28 +0100 (CET)
Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> 	Hi Andrew,
> 
> On Sun, 27 Jan 2008, Andrew Morton wrote:
> > > On Sun, 27 Jan 2008 10:44:40 +0100 (CET) Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > > On Sat, 26 Jan 2008, Andrew Morton wrote:
> > > > > On Fri, 25 Jan 2008 16:06:23 +0100 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > > > > Hare are the ps3av/fb patches for 2.6.25:
> > > > 
> > > > I would have to say: it's a bit late to be submitting things of this nature
> > > > for 2.6.25.  Given the mess everyone has made of everything there's little
> > > > chance that I'll be able to do a 2.6.24-mm1 so this stuff basically goes
> > > > into mainline without public testing.
> > > 
> > > I beg to disagree (of course :-)
> > > 
> > > I posted these patches before, about 2 months ago. Unfortunately I didn't CC
> > > you at that time, so they slipped under your radar.
> > > But the patches did receive public testing even before that, when they entered
> > > Geoff's ps3-linux.git tree.
> > 
> > Should that git tree be in the -mm lineup?
> 
> That may be a good idea! Geoff?

There are lots of powerpc sub-trees.  Kumar's, Geoff's, mine, Olof's,
Grant's, Vitaly's are just the ones I can think of the top of my head.

Shouldn't we just ask Paul to sync up more often rather than have
Andrew track X number of trees that eventually all merge into Paul's
anyway?

josh
