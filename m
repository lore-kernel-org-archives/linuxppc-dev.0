Message-ID: <3F73339C.4050007@mvista.com>
Date: Thu, 25 Sep 2003 11:27:40 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: bradbosch@attbi.com
Cc: Q-ha Park <qha@infoeq.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: using bdi2000 to debug ppcboot on mpc7455
References: <004c01c382ff$de2da2f0$2a21a8c0@qha>	<3F725407.3020907@mvista.com> <16242.64239.133401.668446@waldo.lisle.iphase.com>
In-Reply-To: <16242.64239.133401.668446@waldo.lisle.iphase.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


bradbosch@attbi.com wrote:

>Once you get all this working, could you please do me a favor and let
>me know if you ever have any problems with single step ("mon ti" or
>"stepi") not working?  I have a lot of trouble with this with my
>7447/Discovery II combo and I am trying to figure out if it is a board
>issue or a processor issue or a BDI issue.
>
>
Hi Brad.

I almost exclusively use the telnet interface (and hard breakpoints) to
the bdi b/c I do a lot of early on debug.  I have noticed with certain
processors that a single step will occasionally go several instructions
before stopping.  Unfortunately, I don't remember which processors I see
that on and I've never had a 7447 to try.  What I'm getting at is: a)
yes, I have seen some [minor] breakpoint problems with the bdi (or
possibly the breakpoint implementation on the processor); and b) try
using the telnet interface to eliminate a possible gdb-related problem.

Just my $0.02.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
