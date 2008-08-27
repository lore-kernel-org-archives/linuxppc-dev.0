Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (unknown [76.245.85.235])
	by ozlabs.org (Postfix) with ESMTP id 4042ADDF06
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 02:09:15 +1000 (EST)
Date: Wed, 27 Aug 2008 09:08:59 -0700
From: Brad Boyer <flar@allandria.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 2/4] Add cpufreq driver for the IBM PowerPC 750GX
Message-ID: <20080827160859.GA2009@cynthia.pants.nu>
References: <48B28F23.1000906@hypersurf.com> <200808261329.22699.arnd@arndb.de>
	<48B51A31.8090909@hypersurf.com> <200808271334.16712.arnd@arndb.de>
	<Pine.LNX.4.64.0808271339230.22151@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0808271339230.22151@vixen.sonytel.be>
Cc: linuxppc-dev@ozlabs.org, Kevin Diggs <kevdig@hypersurf.com>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 27, 2008 at 01:40:10PM +0200, Geert Uytterhoeven wrote:
> On Wed, 27 Aug 2008, Arnd Bergmann wrote:
> > On Wednesday 27 August 2008, Kevin Diggs wrote:
> > > Arnd Bergmann wrote:
> > > > Are there even SMP boards based on a 750? I thought only 74xx
> > > > and 603/604 were SMP capable.
> > > > 
> > > Not that I have heard of. I thought it was lacking some hardware that
> > > was needed to do SMP? Can the 603 do SMP?
> > 
> > No, I was wrong about the 603. The machine I was thinking of is actually
> > 604e.
> 
> The BeBox had a dual 603.

I remember going to a talk by some of the Be engineers, and I think they
said that the 603 had terrible SMP performance. My understanding was that
Motorola recommended the 604 for SMP configurations but the 603 was much
cheaper and mostly worked. The 750 is much more like the 603 than the 604.

	Brad Boyer
	flar@allandria.com
