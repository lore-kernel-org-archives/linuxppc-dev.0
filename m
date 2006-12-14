Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id A42C667C08
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 19:24:48 +1100 (EST)
Date: Thu, 14 Dec 2006 09:24:42 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/15] powerpc, celleb: Basic supports for Celleb
In-Reply-To: <1166081837.5253.822.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.62.0612140923040.30229@pademelon.sonytel.be>
References: <200612140138.kBE1cb1O000668@toshiba.co.jp>
	<1166074655.11914.313.camel@localhost.localdomain>
	<1166081837.5253.822.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: paulus@samba.org, arnd@arndb.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 14 Dec 2006, David Woodhouse wrote:
> On Thu, 2006-12-14 at 16:37 +1100, Benjamin Herrenschmidt wrote:
> > > > I'm not sure if it's a good idea to claim CHRP compatibility
> > > > here. Is that a workaround for a specific incompatibility? Normally,
> > > > I'd say you should print "machine\t\t: BEAT %s\n" or
> > > > "machine\t\t: Celleb %s\n", since you are definitely not running
> > > > a CHRP compatible firmware.
> > > 
> > > This is placed only to "trick" Anaconda into installing Fedora Core Linux.
> > > Fedora refuses to be installed into 'unknown' system.
> > 
> > David, can you do some serious LART'ing of whoever is responsible for
> > this in anaconda ? Is there at least an option somebody can pass on the
> > commmand line to make it work on unknown platforms ?
> 
> Define 'work'. I believe it ends up doing _different_ things according
> to the machine type -- in particular the selection of the bootloader
> setup. You want to treat all unknown machines as CHRP? Paul, can we do
> that?

Treating it like CHRP can give unexpected results.

What about printing a big fat warning that it doesn't recognize the machine
type and thus cannot install a bootloader automatically, but continuing
installation?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
