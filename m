Message-ID: <3885EA14.920A68A0@netx4.com>
Date: Wed, 19 Jan 2000 11:45:08 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Embedded planet 860T CLLF HELP!
References: <20000119040935.EB1AB1B2C8@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just placed the latest MPC860T FEC driver on ppc.kernel.org.
This seems to work with the Embedded Planet CLLF.  It is a
pretty bad hack, as the driver should really determine many
of the things in #ifdef's dynamically.

Another thing.  On the "back" side of the CLLF, at the edge
near the four switch pack, you will find an unpopulated R08.
Place a jumper wire across this, as it is the source of the
PHY link change interrupt to the Port C pin.  Future CLLF boards
will have this populated.

And another thing.  This driver doesn't seem to work correctly
on the 860P version of the boards.  I thought I found all 860P
differences, but I guess I missed something.  I am working on it,
and if you have one of these boards, please let me know.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
