Message-ID: <39AA8476.70572FD9@embeddededge.com>
Date: Mon, 28 Aug 2000 11:25:42 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Ronald Wahl <rwa@peppercon.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
References: <Pine.LNX.4.21.0008281358290.1082-100000@goliath.issistance.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ronald Wahl wrote:

> ... But I had to write an
> invalidate_dcache_range() first.

What kernel are you using?  This should have been there, the
Ethernet driver does this......


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
