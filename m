Subject: RE: PATCH: arch/ppc/8xx_io_fec.c
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 27 May 2003 15:47:04 -0400
Message-ID: <AB5AF73EAF23304EA1B932174137CED7030368@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: "Dan Malek" <dan@embeddededge.com>,
	"Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Yes.  There are silicon revisions that require the FEC to
> be enabled for the MDIO to operate.

I tested on revisions B3 and D4, and did not see any problem.
Anyway, fec_stop was already disabling the FEC,
so if it was a problem, it would have broken there.

> The code formatting looks like crap, so that needs to be fixed.

Do you mean for the mixed tabs/spaces? :-( Sorry for that one...
I will fix and resubmit as soon as everyone agree on the changes.

Regards,

Jean-Denis Boyer

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
