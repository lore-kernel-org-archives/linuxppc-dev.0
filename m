Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id BB8EEDDE10
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 17:56:45 +1000 (EST)
Date: Tue, 8 Apr 2008 09:56:42 +0200
From: Sven Luther <sven@genesi-usa.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Question on mpc52xx_common.c
Message-ID: <20080408075642.GA24770@powerlinux.fr>
References: <m21w5map5f.fsf@ohwell.denx.de>
	<fa686aa40804031200n4cd7aeb4g330ab3e2620680e@mail.gmail.com>
	<47FAA0A8.7050602@genesi-usa.com>
	<200804080414.42867.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200804080414.42867.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>, sven@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 08, 2008 at 04:14:42AM +0200, Arnd Bergmann wrote:
> On Tuesday 08 April 2008, Matt Sealey wrote:
> > Grant Likely wrote:
> > > 
> > > Sure, why not?  If the firmware has already set it up correctly and no
> > > devices using it are in use, then the kernel should be okay.  :-)
> > > That said, I can't imagine choosing to not put the cdm node into the
> > > device tree.
> > 
> > *ahem* Efika.
> 
> Maybe we should just give up on making the efika boot with its regular
> device tree and instead add a boot wrapper that either fixes up the
> data provided by its firmware or just adds a proper dt blob?

for 2.6.24, device-tree fixups where added to the linux kernel, since we
don't have a possibility to modify the efika dt, or at least not in a
foreseable future, we should just add more fixups so we can handle
various other problems in it.

Friendly,

Sven Luther
