Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp10.wanadoo.fr (smtp10.wanadoo.fr [193.252.22.21])
	by ozlabs.org (Postfix) with ESMTP id 6E4C62BDB5
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Jan 2005 23:39:20 +1100 (EST)
Date: Mon, 3 Jan 2005 13:47:17 +0100
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-ID: <20050103124716.GB9388@pegasos>
References: <20050103111718.GA11426@pegasos>
	<Pine.LNX.4.44.0501031257040.2302-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.LNX.4.44.0501031257040.2302-100000@opal.biophys.uni-duesseldorf.de>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>,
	Philippe Guyot <pguyot@cvf.fr>,
	Mike Martin <sydneymartin@gmail.com>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, mikemartin@linux.ca
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 03, 2005 at 12:57:35PM +0100, Michael Schmitz wrote:
> > > > > is, so Leigh did a piece of code named "preptools" in order to patch the
> > > > > image with the location of root.
> > > >
> > > > Hey, cool, where is this tool ? We need to package it for debian if it is
> > > > not already, and use it in d-i, and maybe even mkvmlinuz directly.
> > > >
> > >
> > > Just over there....
> > >
> > > http://www.solinno.co.uk/7043-140/downloads.php
> > > But ask Leigh for details.
> >
> > Ok, thanks. ...
> 
> Do we need that added to powerpc-utils perhaps?

Whatever is powerpc-utils ? Mmm, maybe, but then maybe mkvmlinuz would benefit
from being added there too, not sure. In any way i believe it has more its
place inside mkvmlinuz, than inside the more userland powerpc-utils.

Friendly,

Sven Luther
