Message-ID: <38D27077.C11A3B28@embeddededge.com>
Date: Fri, 17 Mar 2000 12:50:47 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Alan Mimms <alanm@unforgettable.com>
CC: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>,
        Richard Hendricks <ra6353@email.sps.mot.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: What is the catch with IDMA on MPC860?
References: <Pine.BSF.4.10.10003171722430.93013-100000@invalid.ed.ntnu.no> <20000317.17233800@alanm.penguinpowered.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan Mimms wrote:
>
> Regarding the "where does the manual say that the performance stinks"

That's an irrelevant question, as no one literally said "the performance
stinks", and no one should.

If you take a look at the timing diagrams and the CPM performance
worksheets, you will find the IDMA is not terribly efficient.  This
is a system design choice.  You can move data significantly faster
using PPC core programmed I/O operations.  The other system design
considerations surround the use of the CPM.  If you choose to use
the IDMA, it affects other CPM operations.

The IDMA could very well statisfy a particular system design.  If
the feature wasn't there, people would be complaining for that
reason.

The 860 is a killer communication processor.  When you start using
some of these other features, it significantly impacts this capability.
In the case if IDMA, control signals used for some communication
capabilities are lost, and you have to choose configuration options
that further erode the communication processing performance.  Just
be aware of this.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
