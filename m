From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Taylor Holliday <wtholliday@ucdavis.edu>,
        linuxppc-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: quad 604 SMP update
Date: Tue, 23 Jan 2001 09:30:31 +0100
Message-Id: <19341218020215.28389@mailhost.mipsys.com>
In-Reply-To: <BHEOKMKGNHLELMKKJJIGIEDACAAA.wtholliday@ucdavis.edu>
References: <BHEOKMKGNHLELMKKJJIGIEDACAAA.wtholliday@ucdavis.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Started removing DIMMS - and the machine booted :-).
>
>Any idea why total bogomips would say 11.96 when it should be 1196?

Mark is having the same issue, I'll look into it.

Note that the DIMMs might or might not be the reason of the problem.
Please tell me what PCI hardware you have in the box (and also, try with
other DIMMs...)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
