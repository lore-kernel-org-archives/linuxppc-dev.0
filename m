Date: Wed, 10 Oct 01 13:13:38 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0110102013.AA25096@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: SBS Palomar II/IV/V port
Cc: paulus@samba.org, val@nmt.edu
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Val Henson <val@nmt.edu> wrote:

> Indeed!  This is on my list of stuff to do - straighten out once and
> for all how BI_INITRD works and then rewrite the Gemini boot process
> to use it.  It seemed like we had two interpretations:
>
> 1. The BI_INITRD boot record contains the start address and the size
>    of the initrd.
>
> 2. The BI_INITRD boot record contains the entire initrd itself (as a
>    really large boot record).
>
> I have no preference either way, I just want someone to tell me which
> way we're going to do it. :)

I really need to be able to have the initrd image located anywhere, forcing it
to be part of the bi_recs list is unacceptable. But if someone really wants
option 2, maybe we can have two different bi_recs to suit everyone?

--
Michael Sokolov				5791 VAN ALLEN WAY
Software Engineer			CARLSBAD CA 92008-7321 USA
SBS Technologies, Inc.			Phone: +1-760-438-6900 x2347
Communications Products			    or  1-888-SBS-COMM x2347
					Fax:   +1-760-438-6985
					E-mail: msokolov@sbs.com
					     or msokolov@ivan.Harhan.ORG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
