Date: Thu, 14 Feb 2002 16:30:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc4xx_serial.c?
Message-ID: <20020214053008.GY1133@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is arch/ppc/kernel/ppc4xx_serial.c of any relevance any more?  It
doesn't include any code unless CONFIG_DEBUG_BRINGUP is defined, and
it doesn't look like it would compile, let alone be called, if it was
defined.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
