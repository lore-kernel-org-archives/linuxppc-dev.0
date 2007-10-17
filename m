Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CB6A5DDE37
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 19:01:31 +1000 (EST)
Subject: Re: vga16fb doesn't build on powerpc (vgacon_remap_base)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0710171047430.29856@pademelon.sonytel.be>
References: <20071016191403.GA5962@nineveh.local>
	<Pine.LNX.4.62.0710171047430.29856@pademelon.sonytel.be>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 19:01:19 +1000
Message-Id: <1192611679.11899.160.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-10-17 at 10:49 +0200, Geert Uytterhoeven wrote:
> > 
> > So VGACON probably doesn't work either on 32bit.  I'm guessing
> arch/powerpc
> > doesn't support PREP.
> 
> It's not only useful for PREP, but also for CHRP.
> 
> > How best could this be fixed up? Or should I just let the thing
> > be?  This is obviously not a new thing, and I don't have any
> hardware
> > that supports this stuff either.
> 
> I remember this problem was present when I still had a working
> LongTrail (which
> is CHRP), long before arch/powerpc/ was created.

It's all very old stuff that needs to be dusted. If you have a setup
where legacy VGA is useable, feel free to do a bit of work on that :-)

Ben.
