Date: Thu, 12 Sep 2002 13:44:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Armin Kuster <akuster@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: OCP Vendor/Device IDs
Message-ID: <20020912034437.GC32156@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On the whole, I think the new OCP stuff is a step in the right
direction.  However, I think the PCI-like Vendor/Device IDs are
unecessary complexity.  They make sense in PCI because they're
provided by the hardware, but they're just made up numbers for OCP.

IMO, we'd be better off using ID strings - these can match the device
names given in the user manuals which are about the closest thing we
have to a manufacturer supplied device ID.  In any case because the
identifiers are necessarily arbitrary, we might as well make them
vaguely memorable strings, rather than random pairs of 16-bit numbers.

PCI and OCP are very different buses, we shouldn't expect the code for
them to look too similar.  OCP should be *much* simpler than PCI.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
