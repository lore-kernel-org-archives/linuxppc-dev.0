Message-ID: <387BCFC2.5958CF10@OARcorp.com>
Date: Tue, 11 Jan 2000 18:50:10 -0600
From: Joel Sherrill <joel.sherrill@OARcorp.com>
Reply-To: joel.sherrill@OARcorp.com
MIME-Version: 1.0
To: David Edelsohn <dje@watson.ibm.com>
CC: Greg Allen <gallen@arlut.utexas.edu>, linuxppc-dev@lists.linuxppc.org,
        crossgcc@sourceware.cygnus.com
Subject: Re: PowerPC G4 AltiVec support for gcc?
References: <200001111958.OAA24314@mal-ach.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Edelsohn wrote:
> 
>         Apple provides a modified version of egcs-1.1.2 with AltiVec
> support.  The changes have not been assigned back to the FSF for inclusion
> in the GCC public sources.  The source code at the Apple website
> apparently only builds on Mac OS X.
> 
>         http://www.publicsource.apple.com/projects/darwin/projects.html
> 
> See "egcs-2" at the bottom, not "cctools-295-2" (nor cc-783.1-1).

If all he wants is inline assembly why does gcc have to be Altivec
aware?
Isn't it enough for the assembler to recognize the instructions?

-- 
Joel Sherrill, Ph.D.             Director of Research & Development
joel@OARcorp.com                 On-Line Applications Research
Ask me about RTEMS: a free RTOS  Huntsville AL 35805
   Support Available             (256) 722-9985

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
