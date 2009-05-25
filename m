Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4109CDE00F
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 16:49:35 +1000 (EST)
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40905242250g2a627c32s2b4c2ed06abd5dc4@mail.gmail.com>
References: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
	<1243160487.22770.59.camel@pasglop> <1243210914.24376.11.camel@pasglop>
	<200905250243.15436.arnd@arndb.de> <1243226023.24376.23.camel@pasglop>
	<fa686aa40905242250g2a627c32s2b4c2ed06abd5dc4@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 25 May 2009 16:49:15 +1000
Message-Id: <1243234155.24376.58.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Albert Herranz <albert_herranz@yahoo.es>, Ilya Yanok <yanok@emcraft.com>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2009-05-24 at 23:50 -0600, Grant Likely wrote:
> It would also be nice for comprehension if the file move and the
> modification were separate commits.  As it is I had to generate the
> diff manually, but I'm not concerned.

Right, I though about that... too late :-) might break it up tomorrow
morning, I don't have time to fix that up right now. Hopefully Kumar
and Ilya will manage to do the same you did to diff it :-)

Cheers,
Ben.
 
