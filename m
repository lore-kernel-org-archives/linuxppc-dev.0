To: Bob Edwards <Robert.Edwards@anu.edu.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Embedded Linux on PPC403GA??
References: <383CC85B.A7DCB448@anu.edu.au>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 25 Nov 1999 16:05:55 +0100
In-Reply-To: Bob Edwards's message of "Thu, 25 Nov 1999 16:25:47 +1100"
Message-ID: <kfy7lj6627g.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bob Edwards <Robert.Edwards@anu.edu.au> writes:

> I have a (small) number of NCD Explora Pro X-terminals with PPC403GA
> chips in them that are currently surplus to requirement. They have
> an early implementation of a PCMCIA slot, as well as all the usual
> X-terminal features including booting from the network using BOOTP and
> TFTP. For this reason, they would make great little router boxes etc.
> or wireless Access Points with an appropriate PCMCIA wireless card
> (my real application).
> 
> As the PPC403GA doesn't have an MMU of any sort, I was wondering if
> anyone on this list had been able to get one to boot Linux using one
> of the MMU-less embedded Linux implementations?

AFAIK there is no port of Linux running on PPCs without MMU.
There is uCLinux (www.uclinux.org), but that is for m68k.

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
