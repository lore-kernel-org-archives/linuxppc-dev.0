Date: Tue, 23 Jan 2001 09:51:15 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: quad 604 SMP update
Message-ID: <20010123095114.A30425@suse.de>
References: <BHEOKMKGNHLELMKKJJIGIEDACAAA.wtholliday@ucdavis.edu> <19341218020215.28389@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19341218020215.28389@mailhost.mipsys.com>; from benh@kernel.crashing.org on Tue, Jan 23, 2001 at 09:30:31AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 23, Benjamin Herrenschmidt wrote:

>
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

This was introduced between test12 (or test9?) and current 2.4.0.
I have 2996 <-> 29.96.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
