Message-ID: <387E71CA.AA583925@netx4.com>
Date: Thu, 13 Jan 2000 19:46:02 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Alan Mimms <alanm@unforgettable.com>, linuxppc-embedded@lists.linuxppc.org,
        dclear@uswest.net
Subject: Re: Embedded planet 860T CLLF HELP!
References: <20000114002344.7BB481B178@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:


> Are the FEC changes purely related to the different PHY, or is there more to
> it than that?

Just the PHY, and that I should really make the driver a little
smarter about automatically configuring them.

By the way, with help from Jim Lewis, we now have this
driver working (undocumented bits in the PHY that need to be
set accordingly).  I will just drop this on the server, and
also include it in the source tree updates.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
