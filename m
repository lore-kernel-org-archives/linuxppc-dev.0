Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0118C68661
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2005 12:59:09 +1100 (EST)
Date: Mon, 31 Oct 2005 19:46:30 -0600
To: Ingmar <i2a@gmx.net>
Message-ID: <20051101014630.GA7938@pb15.lixom.net>
References: <1130645036.29054.229.camel@gaston>
	<20051031002926.M71008@quicknet.nl>
	<2828913a7186e850887d415a8311dc44@penguinppc.org>
	<20051031093907.M8073@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051031093907.M8073@gmx.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: exception vectors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 31, 2005 at 10:58:53AM +0100, Ingmar wrote:
> On Sun, 30 Oct 2005 20:28:49 -0600, Hollis Blanchard wrote
> > On Oct 30, 2005, at 6:35 PM, Ingmar wrote:
> > >
> > > I am trying to overwrite the exception vector space of an ibook G4 :).
> > 
> > Why?
> > 
> 
> For my thesis project I am porting the Minix (v3) OS.

Sounds like using qemu or some other emulator to do the PPC port first
might be an easier choice, and make debugging easier for you during
early bringup.


-Olof
