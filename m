Message-ID: <3A81B333.D638A423@mvista.com>
Date: Wed, 07 Feb 2001 15:42:27 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Borlizzi Giacomo <giacomo.borlizzi@tei.ericsson.se>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: get_pgd_slow() function
References: <3A811BA3.C2793FA3@tei.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Borlizzi Giacomo wrote:

> but I've modified with:

What made you think you need to do this?
Something isn't right.  The 'memcpy' you added just copies zero values
from the init pgd into the new pgd, which the 'memset' already did
for you.  Either the 'memset' you are using isn't correct, or the
act of copying that much data flushed cache lines.  What kind of
processor do you have?


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
