Message-ID: <38F76951.CF7141E8@embeddededge.com>
Date: Fri, 14 Apr 2000 14:54:09 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: No bash prompt
References: <819E3E914E0AD11194DE00805F0D100B0138B833@fbi.infocom.dk> <kfyem88rat5.fsf@kieraypc01.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:

> Seems this problem is way too common...
> How about adding a ppc_md.init function which checks that the internal
> registers are mapped in a sane place, and panics with an informative
> message otherwise?

My plan is just to force all 8xx ports to use the same IMMR address.
This is part of the 8M page mapping of the kernel for performance
enhancements.  I am going to collect as much I/O and IMMR into an
8M space as possible.  Someplace around 0xff000000 is going to be the
"Linux" IMMR setting.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
