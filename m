Subject: Re: quad 604 SMP update
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 23 Jan 2001 10:01:00 -0800 (PST)
Cc: wtholliday@ucdavis.edu (Taylor Holliday),
        linuxppc-dev@lists.linuxppc.org (linuxppc-dev)
In-Reply-To: <19341218020215.28389@mailhost.mipsys.com> from "Benjamin Herrenschmidt" at Jan 23, 2001 09:30:31 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20010123180101.13EE62B54A@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> >
> >Started removing DIMMS - and the machine booted :-).
> >
> >Any idea why total bogomips would say 11.96 when it should be 1196?
>
> Mark is having the same issue, I'll look into it.
>
> Note that the DIMMs might or might not be the reason of the problem.
> Please tell me what PCI hardware you have in the box (and also, try with
> other DIMMs...)
>

I don't have a quad CPU machine, but my 7600 when upgraded to a dual 200MHz
board had similar trouble. It has trouble booting Linux if I have all of
the memory I have in it, or in the wrong places. However, the MacOS can
use both CPUs fine with any configuration I try. I have no PCI cards in
this machine, so that isn't the problem for me. Incidentally, the DIMMS
I have to remove are the ones Apple shipped in it.

	Brad Boyer
	flar@pants.nu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
