Message-ID: <3BB36340.F207E365@mvista.com>
Date: Thu, 27 Sep 2001 13:34:56 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: structs and defs for IDMA on MPC8xx???
References: <3BB33EBA.DF2DCA44@imc-berlin.de> <3BB353D0.F4AA371D@mvista.com> <3BB35CD3.6D152CA6@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

> Have you ever use IDMA?

Yes.

> .... I think there is a significanct difference
> between SDMA and IDMA.

Well, yes.  IDMA (like all CPM devices) use the SDMA function
to access memory.....

> The "standard BD structure" doesn't help much for IDMA, does it?
> So it's not that easy. I already had a look at enet.c...

The IDMA uses the same logical sequence of events and processing
as all CPM devices.  No, the bits aren't exactly the same in the
structure, but if that is all you are concerned about you are
missing the forest and worried about the trees.  The same logical
steps for initializing the parameter ram, allocating DP memory,
initializing BDs, wiring interrupts, and managing BDs is the same
for all CPM devices.  I apologize for not having the trivial data
structures ready for you to use.......

>  It was in April last year!

Sorry I missed it.

> I'll attach what I have so far. It's basicly the patch sent by Greg. I
> am about to check all these defines again.

Well, if this is it, I now understand why it was never integrated.
I don't simply update GPL header files without the corresponding
code that needs those changes.  Wait until you actually have working
driver and I'll update everything at once.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
