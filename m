Message-ID: <3A65EA68.F75481A2@mvista.com>
Date: Wed, 17 Jan 2001 13:54:32 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Borlizzi Giacomo <giacomo.borlizzi@tei.ericsson.se>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: KERNELBASE and MMU
References: <3A648564.671DDDD5@tei.ericsson.se> <3A64C847.D2414D1D@mvista.com> <3A65E51B.50FC28EC@tei.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Borlizzi Giacomo wrote:
>
> Does you say that linux code is not PIC? (position indipendent code)

No it is not.  You can move it around a little if you _really_
understand the details.  For any PowerPC processor there is no
reason to change the location regardless of the system implementation.

> Why such constraint on physical memory area? It don't make some
> limitation on portability of code?

No portability problem.  This code runs on more processors and
boards more easily than anything else in the world.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
