Message-ID: <3A818DAE.3182B163@mvista.com>
Date: Wed, 07 Feb 2001 13:02:22 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
        linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <3A6CCBDC.3D7B722A@mvista.com>
		<Pine.HPX.4.10.10101231050450.3872-100000@gra-ux1.iram.es>
		<14975.55035.835724.234984@tango.linuxcare.com.au>
		<3A806D89.16B31EA0@mvista.com>
		<14976.30150.97137.755604@tango.linuxcare.com.au>
		<3A808560.6FF96E3C@mvista.com> <14976.38302.725479.486320@diego.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> Sounds nice, got a concrete proposal?  It's easy to criticise.

Sorry, I don't mean to criticize (or criticise :-).  Well, maybe
just a little......in general some of the Linux design seems to
be just a little short sighted (not picking on you Paul, I even
do this :-).  We tend to fix an immediate problem today without
stepping back for 30 seconds to apply some knowledge gained over
the past 50 years of computer development.

Over the past month or so, I have been part of some new processor
ports and trying to find solutions for large memory systems.  It
has pushed me deep into the VM design again, I am trying to clean
up some of the redundant functions we have and find some longer term
solutions instead of providing a "hack of the day" that will just
need to be thrown away in favor of something else tomorrow.

I don't yet have a proposal, and in retrospect it does seem the
discussion started on a negative tone.  I'm thinking about flying
out to some Caribbean island for a week or so to work on this (among
other things :-).

I have a couple of things to update for the other processor work I
am doing, and after that I will experiment with a few things.  I'll
let you know if I can find something useful.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
