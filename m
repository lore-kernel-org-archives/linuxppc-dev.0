MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: ioremap on powerpc question
Date: Tue, 16 Jul 2002 08:25:20 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167CFFA@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Matt Porter" <porter@cox.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[...]
> >
> > However, on powerpc, as soon as I try to do, for example:
> >
> > 	*buf = '\0'; // write one char to virt addr returned by ioremap
> >
> > It blows up with a machine check.
>
> You are hitting a 440GP specific feature.  ioremap is trapping
> ranges of addresses and "fixing them up" with the proper ERPN.
> Unfortunately, I left the default on a no match as an ERPN=1
> which will ioremap 1 0400 0000.   That's why you get a bus error.
>
> Try this patch:

Thanks!  That appears to work.
and thanks for explaining the rationale on the readb/writeb requirement.

-- steve

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
