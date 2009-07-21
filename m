Return-Path: <paubert@iram.es>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C6E3AB70D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jul 2009 22:00:29 +1000 (EST)
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 44FBADDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2009 22:00:28 +1000 (EST)
Date: Tue, 21 Jul 2009 14:00:07 +0200
From: Gabriel Paubert <paubert@iram.es>
To: David Jander <david.jander@protonic.nl>
Subject: Re: Best hardware platform for native compiling...
Message-ID: <20090721120007.GA23164@iram.es>
References: <200907211116.52963.david.jander@protonic.nl>
	<20090721095251.GG32034@lisas.de>
	<200907211231.37299.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200907211231.37299.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 21, 2009 at 12:31:36PM +0200, David Jander wrote:
> On Tuesday 21 July 2009 11:52:51 you wrote:
> > On Tue, Jul 21, 2009 at 11:16:52AM +0200, David Jander wrote:
> > > For bigger systems we often run a debian-derived OS like Ubuntu, and many
> > > pieces are compiled natively on the target... just because it is easy and
> > > quick to do, and cross-compiling certain packages can be a real pain.
> > > But, a 400 MHz e300 core is not really fast for compiling, so I have been
> > > considering buying some sort of PowerPC-based system with a faster
> > > processor, just as a "build-server" (a G5 would do wonders I guess).
> > >
> > > It seems like the only real option is one of the smaller IBM Power
> > > servers, but that seems overkill to me. We also don't feel like buying
> > > some old second-hand Apple gear.
> > >
> > > Is there any other available and affordable platform that can be used to
> > > run linux and compile software natively for 32-bit PowerPC?
> >
> > Have a look at the YDL PowerStation:
> >
> > http://us.fixstars.com/products/powerstation/
> >
> > It is more or less a quad G5.
> 
> This looks great! Thanks a lot for the tip.
> I still have to figure out how to get one of these delivered to Europe, but 
> that shouldn't be such a big deal...

Well, I got one recently here in Spain. Shipping charges are fairly 
large (it's not exactly a light and compact machine). But the current 
dollar exchange rate helps ;-)

Now I have not yet found the way to install Debian on it
(it refuses to boot Debian's CDROM), but I have not had
time to investigate either.

	Regards,
	Gabriel
