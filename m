From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15267.1137.548406.498207@cargo.ozlabs.ibm.com>
Date: Sat, 15 Sep 2001 17:34:09 +1000 (EST)
To: Dan Malek <dan@mvista.com>
Cc: tom_gall@vnet.ibm.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: G3, 2.4.10-pre8 and seg faults
In-Reply-To: <3BA25C1D.BD7BDC3D@mvista.com>
References: <3BA252AB.6C8D6AF1@vnet.ibm.com>
	<3BA25C1D.BD7BDC3D@mvista.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> Tom Gall wrote:
>
> >   I've got a B+W 500 Mhz G3 system running the 2.4.10-pre8 linuxppc_2_4_devel
> > kernel from bk and I'm continuing to see random seg faults.
>
> I'll be working on 603e core processors (82xx) this weekend.  I'll
> keep you posted on any problems I find.

I just tried all three of Linus' 2.4.10-pre9, linuxppc_2_4, and
linuxppc_2_4_devel on a 3400 powerbook, which has a 200MHz 603e.  All
three kernels worked just fine, so other machines with a 603e core
ought to run just fine.

Is anyone else seeing random segfaults like this?  If so, on what sort
of machine using which kernel?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
