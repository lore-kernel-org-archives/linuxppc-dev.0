Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 91D0ADDED1
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 17:04:02 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 16 Jun 2008 09:03:59 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1213591838.8129.123.camel@pasglop>
Message-ID: <20080616070359.300020@gmx.net>
MIME-Version: 1.0
References: <20080616014615.GA8960@nineveh.local>
	<1213591838.8129.123.camel@pasglop>
Subject: Re: BUG() in current git, __dma_alloc_coherent, Beige G3
To: jfannin@gmail.com, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Mon, 16 Jun 2008 14:50:38 +1000
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Joseph Fannin <jfannin@gmail.com>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: BUG() in current git, __dma_alloc_coherent, Beige G3

> > This is 100% reproducable.  I can't really recall the last kernel I
> > built and booted successfully on this box -- the best I can say is
> > that the 2.6.24-ish kernel Ubuntu ships works.
> > 
> > I should probably mention that I've been having a little trouble with
> > the IDE drive in this machine -- but the drive isn't the problem:
> > 
> >     * This is 100% reproducible with the current git kernel, and
> >           doesn't happen w/the Ubuntu kernel
> >     * The traceback and dump does not vary between boots
> >     * The kernel BUGs out well before the disks are detected (and it's
> >           a _drive_ problem)
> > 
> > ... etc.  :-)  I don't want to send anyone on a wild goose chase, but
> > yeah, it's not the hardware.  ;-)
> > 
> > So, what can I do to help find the problem here?  Git says no one's
> > touched that file in a while, and tracing through this problem is
> > above my skill level here.  I'll attach my .config, and put the
> > vmlinux up:
I discovered this bug some time ago and reported it on the list.
See here for more info:
http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056128.html
Anyway I don't think your machine needs dma-noncoherent.

best regards,

Gerhard

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
