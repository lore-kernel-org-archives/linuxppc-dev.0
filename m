To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] enhanced i2c driver for MPC8xx/MPC8260 CPM ... 
In-reply-to: Your message of "Tue, 28 May 2002 07:01:25 -0400"
             <3CF36385.8020505@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 28 May 2002 21:39:31 +1000
Message-ID: <27079.1022585971@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 28 May 2002 07:01:25 -0400, Dan Malek <dan@embeddededge.com> writes:
>Murray Jensen wrote:
>
>> enhanced i2c driver for MPC8xx/MPC8260 CPM ...
>
>These have to be submitted through the i2c project on sourceforge (or
>where ever it is).  The i2c isn't part of the kernel source tree, it is
>applied on top from their repository from time to time.

Tom said this to me as well, and I agree in principle, but I thought it should
first be reviewed by the Linux/PPC Embedded community. It's actually quite a
hacky driver, but in my defence, I could claim the original driver was hacky
to start with - I really didn't change it a lot, conceptually (what I mean by
this is that it could be much improved in the way it does things - more
correct, more efficient, etc, but hey it works reliably for me, so there isn't
a lot of incentive to fix it - its only i2c after all :-).

Also, the i2c people probably wouldn't have any hope of testing this driver,
since nothing else is going to have a CPM, and in fact I haven't even tested
it myself on the 8xx platform yet. I propose we get it into linuxppc_2_4_devel
and have it hammered on by others, and when/if it gets the thumbs up from the
Linux/PPC Embedded community, we/I contribute it back to the i2c project -
really just for the sake of completeness. Comments? Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
