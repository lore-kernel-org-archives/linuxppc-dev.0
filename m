Subject: Re: new 601 port starting point?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Weis <djweis@sjdjweis.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.21.0306021217270.19576-100000@oliver.internal.sjdjweis.com>
References: 
	 <Pine.LNX.4.21.0306021217270.19576-100000@oliver.internal.sjdjweis.com>
Content-Type: text/plain
Message-Id: <1054624406.541.70.camel@gaston>
Mime-Version: 1.0
Date: 03 Jun 2003 09:13:27 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-06-02 at 19:19, Dave Weis wrote:
> I'm going to be working on the mca rs/6000 machines again. The kernel has
> changed a bit since I last tried, so I need some advice.
>
> Which platform should I base my work on? It's a 601 machine, no pci or isa
> bus.
>
> I have downloaded the 2.4.20-benh rsync-able tree to start with.

I don't recommend using my tree for developing a new platform,
you should rather start from either the official 2.4.x tree in
kernel.org or the linuxppc_2_4, though the later is probably
what you want.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
