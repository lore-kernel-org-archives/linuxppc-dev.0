From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15314.48871.176187.508759@cargo.ozlabs.ibm.com>
Date: Sun, 21 Oct 2001 22:26:15 +1000 (EST)
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.13-pre5 crash when mounting proc
In-Reply-To: <p04330100b7f7f805ef9a@[24.163.33.28]>
References: <p04330100b7f7f805ef9a@[24.163.33.28]>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Stefan Jeglinski writes:

> 6500, Linux/PPC 2KQ4 running 2.2.19, I compiled 2.4.13-pre5, rsynced
> from bk yesterday.

linuxppc_2_4 or linuxppc_2_4_devel?

> On boot, when it gets to "mounting proc
> filesystem," I get a break into the mon debugger, but I have no
> keyboard response (so no backtrace). The info I can copy is:

You have an ADB keyboard, no?  I am surprised the keyboard doesn't
respond.

> vector: 300 at pc = c02432fc lr = c00544e0 msr = b032 sp = c5dc3ef0
>
> plus some more that I'm not sure will help much. For this output
> alone, should I include System.map also?

Yes, or alternatively find out where those pc and lr addresses are in
the System.map list and tell us the nearest symbols and their values.

> Is this a known problem?

Not to me...

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
