Message-Id: <m12wo4c-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: Floating Point problems with Linux on the EST SBC8260
To: roman@alerton.com, linuxppc-embedded@lists.linuxppc.org
Date: Tue, 30 May 2000 11:36:54 -0400 (EDT)
In-Reply-To: <392C3ED0.594EB6F7@alerton.com> from "Bill Roman" at May 24, 2000 01:42:56 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Date: Wed, 24 May 2000 13:42:56 -0700
> From: Bill Roman <roman@alerton.com>

> diekema_jon wrote:

> > - I am looking for a floating point validation test suite written in
> >   C.  The test suite should start with the fundamentals and work out
> >   from there.

> Try paranoia.c. A web search should turn up multiple copies, I found one at

>     http://www.enseeiht.fr/NetLib/paranoia/index.html

> A while back I had the floating point emulator from kernel 2.3
> patched into kernel 2.2.13 running on an MBX, and it did reasonably
> well on this test as I recall.

paranoia.c was quite helpful in verifying the floating point operation
on the EST SBC8260 board with a MPC8260 Rev A.1.  I statically compiled
this program under Yellow Dog Linux champion server 1.2, and ran it
on the SBC8260.  paranoia.c didn't find anything to complain about. :)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
