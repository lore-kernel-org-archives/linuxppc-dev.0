Date: Mon, 25 Feb 2002 12:47:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: EP405 PCI interrupt mapping
Message-ID: <20020225014743.GD15788@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is the current PCI interrupt mapping stuff for the EP405
(i.e. ppc405_map_irq() in ep405.c) expected to work, or has it just
been copied from walnut and never updated for ep405?  It looks bogus
to me.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
