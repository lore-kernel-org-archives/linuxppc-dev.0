Message-ID: <3C082200.B032FE0E@mvista.com>
Date: Fri, 30 Nov 2001 16:19:12 -0800
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: Ralph Blach <rcblach@us.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
References: <OF04BCE99E.8AF57CF2-ON85256B14.00425D94@raleigh.ibm.com > <15368.891.368917.13579@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
>
> Basically I want the knowledge that "because this is a 405gp chip we
> must have an XYZ ethernet controller at address FOO using interrupt
> N" to be concentrated in one place, not spread out through the
> code.  Then when IBM brings out a 405gp-A that has two XYZ's (neither
> of which are at the same address as in the 405gp) there is just one
> place that we have to change.
>

Exactly.

Actual its an issue for the NP405H & L.  I will outline how this can be
addressed soon + all the other 4xx internal pripherials.

> Paul.
>

--armin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
