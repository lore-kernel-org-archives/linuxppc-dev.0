Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp5.wanadoo.fr (smtp5.wanadoo.fr [193.252.22.26])
	by ozlabs.org (Postfix) with ESMTP id EA4A62BDB5
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 02:56:50 +1100 (EST)
Date: Mon, 3 Jan 2005 17:04:35 +0100
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-ID: <20050103160435.GB13663@pegasos>
References: <20050103124716.GB9388@pegasos>
	<Pine.LNX.4.44.0501031545370.11702-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.LNX.4.44.0501031545370.11702-100000@opal.biophys.uni-duesseldorf.de>
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

On Mon, Jan 03, 2005 at 04:24:40PM +0100, Michael Schmitz wrote:
> > > > > http://www.solinno.co.uk/7043-140/downloads.php
> > > > > But ask Leigh for details.
> > > >
> > > > Ok, thanks. ...
> > >
> > > Do we need that added to powerpc-utils perhaps?
> >
> > Whatever is powerpc-utils ? Mmm, maybe, but then maybe mkvmlinuz would benefit
> 
> WTF is mkvmlinuz?

mkvmlinuz is a nice little kernel-derived tool by Jens and me, which allows
one to create a zImage.chrp, or zImage.coff or whatever, from the
arch/ppc/boot/* stuff and the plain vmlinux kernel. It avoids having to chip
the same kernel X times as we did on 2.4 kernels, and can be used as a
kernel-package postinst hook to automate this process.

> > from being added there too, not sure. In any way i believe it has more its
> > place inside mkvmlinuz, than inside the more userland powerpc-utils.
> 
> Whatever. Just thought people might want to use it to change kernel
> options on the fly, without invoking mkvmlinuz.

Well, we would need at least a .udeb containing it. IF you can add it to
powerpc-tools, then nice. I think that maybe mkvmlinuz would be also a
candidate to be part of the powerpc-tools, not sure though.

Friendly,

Sven Luther
