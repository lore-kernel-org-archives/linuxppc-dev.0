Message-Id: <v04003a02b6b35c7a4a82@[24.70.162.12]>
In-Reply-To: <20010216210927.A9F26DBA2E@atlas.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 16 Feb 2001 16:47:18 -0600
To: "Iain Sandoe" <iain@sandoe.co.uk>,
	Karim Yaghmour <karym@opersys.com>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: ltrace for ppc
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 3:10 PM -0600 2/16/2001, Iain Sandoe wrote:
>> If you're interested in ltrace, you may want to take a look at the
>> Linux trace toolkit (http://www.opersys.com/LTT). It runs fine
>> on PPC too.
>
>I'm *very* interested in any toolkit that can provide point-to-point
>_timing_ of system calls, IRQ handling, system usage. latency etc. etc. (a
>la TIMEPEGS or Andrew Morton's amlat on x86).
>
>what do we have (existing) on PPC?
>
>I did an IRQ latency thing on 2.2.x and Cort has proposed using RTlinux to
>make IRQ measurements (well, I think he's done it, actually)...  that will
>give headlines - but not tell us which drivers/functions are the rouges.
>
>I was considering doing a port of Andrew Morton's stuff - but got stuck when
>I tried to run with HZ=1024 - it trashed adb... and I haven't got back to it
>yet.

What about SGI's Kernprof stuff? <http://oss.sgi.com/projects/kernprof/>.

I was going to poke at it to see if/what it breaks a while back when there
was some talk of weird SMP slowdowns, but I think I got sidetracked with
something else.

Anyways, it's probably worth looking into.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
