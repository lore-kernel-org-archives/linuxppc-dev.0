Message-ID: <39821DD7.ED0DA0A2@embeddededge.com>
Date: Fri, 28 Jul 2000 19:57:11 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: CONFIG_PPC != Mac
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Or vice versa....

So, the 2.4.0 PowerPC tree is now Mac workstation only?  Please,
we can't make the assumption that CONFIG_PPC is a Macintosh.  It
breaks all PowerPC embedded systems (or anything that isn't a recent
Mac with USB).  There is a CONFIG_MAC, isn't that enough to do the same
thing?

Can we quickly resolve this?  The BK tree doesn't build for many
systems right now.

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
