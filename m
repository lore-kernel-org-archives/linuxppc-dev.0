Message-ID: <3A37B2E4.B3944354@mvista.com>
Date: Wed, 13 Dec 2000 12:33:24 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Arto Vuori <avuori@ssh.com>
CC: Graham Stoney <greyham@research.canon.com.au>,
        Brian Ford <ford@vss.fsi.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
References: <20001212182856.A8336@brixi.research.canon.com.au> <Pine.GSO.4.21.0012120933330.24199-100000@eos> <20001213121554.B17129@brixi.research.canon.com.au> <3A37A048.46E692A0@mvista.com> <3A37B08A.3FE08AF7@ssh.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Arto Vuori wrote:

> We also found and fixed some problems including:

I have been pushing driver updates into the BK linuxppc_2_5 tree,
but not into the linuxppc_2_3 tree as we are trying to stablize
that for 2.4.  All of these you mentioned, and others have been
updated.  The MII interface is still broken for some PHYs.

Once the linuxppc_2_5 driver is better, I will push it into the 2.4
baseline.

For all processors, the BK linuxppc_2_5 tree has many more updates
than the more visible 2_3 tree.

Send me any patches you have as you create them.  It is lots easier
to add a few lines here and there than to get a bunch of changes
from an old baseline.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
