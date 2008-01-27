Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <479CE315.6070508@am.sony.com>
Date: Sun, 27 Jan 2008 12:01:25 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 00/11] ps3av/3fb patches for 2.6.25
References: <20080125150623.202631389@vixen.sonytel.be>
	<20080126220139.5385f2c7.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0801271041160.10193@vixen.sonytel.be>
	<20080127021659.fb6c72a1.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0801271215120.10514@vixen.sonytel.be>
In-Reply-To: <Pine.LNX.4.64.0801271215120.10514@vixen.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>,
	Antonino Daplas <adaplas@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 01/27/2008 03:15 AM, Geert Uytterhoeven wrote:
> On Sun, 27 Jan 2008, Andrew Morton wrote:
>> > On Sun, 27 Jan 2008 10:44:40 +0100 (CET) Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
>> > I posted these patches before, about 2 months ago. Unfortunately I didn't CC
>> > you at that time, so they slipped under your radar.
>> > But the patches did receive public testing even before that, when they entered
>> > Geoff's ps3-linux.git tree.
>> 
>> Should that git tree be in the -mm lineup?
> 
> That may be a good idea! Geoff?

Sounds good.

ps3-linux.git is used by a lot of active PS3 developers, so
already gets some good testing on PS3, but I think if we get
the stable patches into -mm, then we will get more testing on
non-PS3 platforms, which is something I think we need.

As a start, I'll work toward getting patches from ps3-stable
into -mm.  I think it is too late now for the 2.6.25 patches,
so the 'for 2.6.26' ones.  To make this work, we (PS3
maintainers) need to get our patches moved from ps3-wip to
ps3-stable in a timely manner.  As of late, it seems patches
have lingered in ps3-wip too long.
 
-Geoff
