Mime-Version: 1.0
Message-Id: <a05111b00b92567b867f3@[10.0.0.42]>
In-Reply-To: <Pine.LNX.4.33.0206061251190.20358-100000@blues.wcg.mcgill.ca>
References: <Pine.LNX.4.33.0206061251190.20358-100000@blues.wcg.mcgill.ca>
Date: Thu, 6 Jun 2002 12:51:22 -0700
To: Christopher Murtagh <christopher.murtagh@mcgill.ca>,
	<linuxppc-dev@lists.linuxppc.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: SMP/HIGHMEM/7450 status ?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:09 PM -0400 6/6/02, Christopher Murtagh wrote:
>On Thu, 6 Jun 2002 benh@kernel.crashing.org wrote:
>>Xserve uses 7455 (like newer dual G4s), which doesn't seem to exhibit
>>the problem.
>
>  Damn... does this mean that the 7450 machines are lemons (wouldn't
>surprise me if the answer was a resounding 'yes')?

Apple did hold off on dual 7450 until rev 2.1 came out and fixed some
of the nastier SMP errata, so presumably they at least thought there
were no SMP showstoppers left in rev 2.1.  As far as I can tell they
are pretty stable under OS X.

Linux is probably just missing some deep magic needed for working
around one or more of the errata that do still apply to rev 2.1.  The
trouble is figuring out exactly what's wrong... it can be VERY
difficult to understand all the ramifications of a CPU bug
(particularly a SMP related bug) until you use a bus analyzer to
snapshot bus traffic during a crash, or probe CPU registers via JTAG
after it has crashed, etc.
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
