To: Lucinda Schafer <lucsch@adaptivemicro.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xx MMU Table Walk Base (was Re: kernel crashes at Instructio nTLBMiss ) 
In-Reply-To: Message from Lucinda Schafer <lucsch@adaptivemicro.com>
   of "Mon, 19 Jun 2000 11:58:40 EST." <A109131318C4D1119AC20060088DECE330F3EA@MAIL>
Mime-Version: 1.0
Content-Type: text/plain
Date: Tue, 20 Jun 2000 13:55:36 +1000
Message-ID: <25905.961473336@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 19 Jun 2000 11:58:40 -0500, Lucinda Schafer <lucsch@adaptivemicro.com>
writes:
>Murray,
>
>Were you ever able to resolve your problems? We are getting kernel mode
>software emulation kernel panics in some of the routines that you mention
>here on a custom MPC823 board using the 2.2.13 tarball with FPU emulation
>and MM patches.
>
>Lucinda Schafer
>Staff Software Engineer
>Adaptive Micro-Ware, Inc.

Hi Lucinda, my problems related to the 2.3.x/2.4.x kernel. I was describing
how I fixed it for that code base. I don't believe it applies to the 2.2.x
code base.

You should post more details about your problem to the list (don't worry
about being verbose, the more info the better - but don't post megabytes,
there is a sensible balance there somewhere). People such as Dan Malek,
et al, have seen much of it before, and in a majority of cases can point
you to a solution very quickly.

If you don't provide enough info though, you get fried in a blast furnace
and you may never recover :-) Ask yourself lots of questions when describing
the problem because that's what we all do when we read it. If you can answer
most of the obvious questions by including info it will save two or three
iterations on the mailing list (which might be days if the people asking the
questions are on the opposite wake/sleep cycle to you - as is generally the
case for me here in Australia, except when I hack late at night :-). Cheers!
								Murray...

PS: for those that care, the question I raised was answered by the change
I suggested being incorporated into the latest development kernel. The
set_context() function now takes two arguments, the first is the usual
context number, and the new second argument is the new pgdir base address
(which is converted to a physical address and stored in the TWB register).
I'm not sure this is a 100% correct solution, but it will work (until someone
uses switch_mm() somewhere else besides the _switch() routine - I don't know
how likely this is).
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
