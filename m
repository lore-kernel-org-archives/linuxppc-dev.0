Message-ID: <3B8436B7.FF5CACAE@mvista.com>
Date: Wed, 22 Aug 2001 18:48:23 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: status of linuxppc_2_4_devel for ppc405gp
References: <200108222229.XAA01202@lougher.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Phillip Lougher wrote:

> What doesn't work with the treeboot loader?  From what I've seen,
> there's nothing much to break?

The 4xx stuff wasn't kept up to date in the linuxppc_2_4 tree.
I have new things to check in there, and along with other bootloader
changes we want to accomplish I'm just trying to merge it with
others.  There are more 4xx processors than Walnut boards with
the treeboot rom, and we have to accomodate those as well.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
