Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0670FDDEBC
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 08:25:37 +1100 (EST)
Subject: Re: undefined symbol 'PS3_PS3AV'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mundt <lethal@linux-sh.org>
In-Reply-To: <20070214101719.GA25319@linux-sh.org>
References: <45D2A835.7020606@m3y3r.de>
	<Pine.LNX.4.62.0702140955130.17463@pademelon.sonytel.be>
	<20070214090701.GA11088@linux-sh.org>
	<Pine.LNX.4.62.0702141100470.2949@pademelon.sonytel.be>
	<20070214101719.GA25319@linux-sh.org>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 08:25:08 +1100
Message-Id: <1171488308.20192.171.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Thomas Meyer <thomas@m3y3r.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-02-14 at 19:17 +0900, Paul Mundt wrote:
> On Wed, Feb 14, 2007 at 11:02:06AM +0100, Geert Uytterhoeven wrote:
> > On Wed, 14 Feb 2007, Paul Mundt wrote:
> > > This would seem like a reasonable candidate for a 'depends on' instead of
> > > a select..
> > 
> > That's what we originally had. But for the user it's simler if he can just
> > enable ps3fb and/or ps3snd (sound driver not yet finished), which both select
> > PS3_PS3AV.
> 
> Why not just have PS3_PS3AV def_bool y if ps3fb || ps3snd? Or if that
> doesn't work, just place the PS3FB option in arch/powerpc/platforms/ps3/Kconfig.
> 
> Of course if select obeyed the depends on, this wouldn't be a problem
> either..

I'd rather fix Kconfig to do the later...

Ben.
