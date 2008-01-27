Return-Path: <akpm@linux-foundation.org>
Date: Sun, 27 Jan 2008 02:16:59 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 00/11] ps3av/3fb patches for 2.6.25
Message-Id: <20080127021659.fb6c72a1.akpm@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0801271041160.10193@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
	<20080126220139.5385f2c7.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0801271041160.10193@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	cbe-oss-dev@ozlabs.org, adaplas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Sun, 27 Jan 2008 10:44:40 +0100 (CET) Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> 	Hi Andrew,
> 
> On Sat, 26 Jan 2008, Andrew Morton wrote:
> > > On Fri, 25 Jan 2008 16:06:23 +0100 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > > Hare are the ps3av/fb patches for 2.6.25:
> > 
> > I would have to say: it's a bit late to be submitting things of this nature
> > for 2.6.25.  Given the mess everyone has made of everything there's little
> > chance that I'll be able to do a 2.6.24-mm1 so this stuff basically goes
> > into mainline without public testing.
> 
> I beg to disagree (of course :-)
> 
> I posted these patches before, about 2 months ago. Unfortunately I didn't CC
> you at that time, so they slipped under your radar.
> But the patches did receive public testing even before that, when they entered
> Geoff's ps3-linux.git tree.
> 

Should that git tree be in the -mm lineup?
