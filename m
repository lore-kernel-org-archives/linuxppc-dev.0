Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0DFAE6865A
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 09:02:50 +1100 (EST)
Date: Sun, 30 Oct 2005 16:02:09 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051030220209.GB11327@pb15.lixom.net>
References: <1130645036.29054.229.camel@gaston>
	<20051030175956.GB7039@pb15.lixom.net>
	<1130706859.29054.283.camel@gaston>
	<20051030213517.GA11327@pb15.lixom.net>
	<1130708514.29054.292.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1130708514.29054.292.camel@gaston>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, bcm43xx-dev@lists.berlios.de
Subject: Re: 30 bits DMA and ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 31, 2005 at 08:41:54AM +1100, Benjamin Herrenschmidt wrote:
> > Yep, the table is already split once, and I'm not sure in retrospect how
> > useful that split was anyway, it can maybe go away. Switching it around
> > shouldn't be a big issue.
> 
> No real need to split permanently... the search could be restricted to a
> given range easily.

Yeah, that's what it does now too, if it can't find anything in the
"right" part of the table, it'll try the other. So other devices would
use the same section if the "regular" table got full.


-Olof
