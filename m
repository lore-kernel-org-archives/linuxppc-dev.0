Date: Mon, 12 Aug 2002 09:34:30 -0500
From: Peter Bergner <bergner@borg.umn.edu>
To: Paul Mackerras <paulus@au1.ibm.com>
Cc: Mike Corrigan <mikejc@us.ibm.com>,
	Anton Blanchard <anton@samba.org>,
	linuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: FP save/restore code in ppc32/ppc64 kernels
Message-ID: <20020812143430.GA35003@congo.borg.umn.edu>
References: <OFD0ACCC08.6A2BB8EC-ON86256C0F.004C0678@us.ibm.com> <15698.61945.251112.661796@argo.ozlabs.ibm.com> <20020808210927.A870681@brule.borg.umn.edu> <15703.8116.483898.162119@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15703.8116.483898.162119@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
:> It might be a good idea to clear the fpscr after saving it out to
:> the thread struct though...
:
: Exactly.  We don't.  If we did then we could do as you say and it
: would work on SMP.  We could do that as long as we are sure we won't
: ever want to do a UP kernel on ppc64...

Or we could force the UP kernel to act like the SMP kernel and not
use lazy save.  How big of a "win" is lazy save on UP kernels?
I will also note that UP kernels haven't worked for nearly 2 years
on PPC64.

Peter

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
