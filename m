Return-Path: <jonathan@jonmasters.org>
Received: from smtp.mailbox.co.uk (smtp.mailbox.co.uk [195.82.125.32])
	by ozlabs.org (Postfix) with ESMTP id 414C667A6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 22:58:06 +1000 (EST)
Message-ID: <424BEDFC.8080300@jonmasters.org>
Date: Thu, 31 Mar 2005 13:33:00 +0100
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <424ACFF1.5000403@bitsim.se>
	<111d2ae873d1bfee413409dfc4f2f064@freescale.com>
In-Reply-To: <111d2ae873d1bfee413409dfc4f2f064@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>,
	Sylvain Munaut <tnt@246tNt.com>,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Jakob Viketoft <jakob.viketoft@bitsim.se>
Subject: Re: Platform bus/ppc sys model...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Kumar Gala wrote:

|> My intention was to give a device tree structure to the kernel at boot
|> time via a (pseudo?) pointer in bd_info or similar. Then you would only
|>  need to recompile a little bootloader (which is needed for setting up
|> the FPGA anyway) with this structure for every specific card. You could
|> even be shrewd enough to have a single kernel image but several
|> structures to launch several processors on the same chip. Does it sound
|> like a sane solution?

This got resurrected recently. Some of us have been talking privately
about it and I should have time with a board and BDI shortly. The idea
above about the bd_info pointer is precisely what I've been working with
people off list on.

| I think this is reasonable.  The best device tree would be a flattened
| OF tree since we are trying to move the world in that direction.  Jon
| Masters around?

Yes, but I've been tied up with worky and magazine stuff again. If
someone wants to work with me then this might actually happen.

Cheers,

Jon.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCS+38eTyyexZHHxERAhKmAJ9v2k8rvFjB+W9OmXu4P7blHiWIkQCglEFk
AA2fZEsXmpWV0Jj/Z2OCrxA=
=oVje
-----END PGP SIGNATURE-----
