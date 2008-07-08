Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 Jul 2008 14:26:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Mikrotik RouterBoard 333
Message-ID: <20080708042631.GB7328@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Does anyone on this list have contacts with the makers of this board?

Its firmware apparently provides a flattened device tree to the OS.
And while this step towards world domination is flattering, it's an
example of what I feared when people first got enthusiastic about the
idea of including flattened device trees in firmwares.  The tree has
not, AFAIK, been past this list, and has apparently not been reviewed
by someone knowledgeable about device trees.  In short, it's crap, and
now that it's embedded in the firware we can't really fix it.

So, to any embedded hardware/firmware vendors doing Linux ports out
there.  I certainly encourage you to use flattened device trees, but
can I please suggest you put the blob into your kernel image (in the
bootwrapper strictly speaking), rather than into the flashed firmware.
It's a lot easier to fix mistakes that way.

There are situations where it's nice to have the device tree in
firmware, but there are many others where it buys little to nothing.
People seem to be a bit overenthusaistic on the concept at the moment.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
