Message-ID: <3E63C905.5000306@embeddededge.com>
Date: Mon, 03 Mar 2003 16:28:37 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
References: <IGEFJKJNHJDCBKALBJLLOEKGFKAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> I have been playing with the copy_page() function in arch/ppc/kernel/misc.S
> and gained about 30% speed up for my mpc860, rev D4 MHz.

Have you found the discussion in linuxppc-dev about the work Paul has done
on this in general for PowerPC?  It may help avoid repeating some work and
provide some guidance.....

And don't forget....many applications aren't heavily 'copy-centric' and it
may be beneficial to not blow away the caches in those cases.  That is, if
you apply systems engineering methods to your testing instead of just focusing
on such a low level detail, you may discover you are wasting your time and
from an overall system application you may be providing little benefit or
even a overall degradation in system performance.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
