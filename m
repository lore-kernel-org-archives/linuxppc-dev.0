Date: Sun, 6 May 2001 22:47:46 +0100
From: Paul Nasrat <pnasrat@uk.now.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: Airport in BenH's kernels
Message-ID: <20010506224746.A21305@uk.now.com>
References: <200105062011.WAA00674@piglet.grunz.lu> <20010506202801.14354@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010506202801.14354@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Sun, May 06, 2001 at 10:28:01PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, May 06, 2001 at 10:28:01PM +0200, Benjamin Herrenschmidt wrote:
>

> Thanks ! The driver have been a pretty quickly moving target lately
> as Jean Tourrihles and I were working to finally have a common code
> base for airport and orinoco_cs without duplicating the driver.
>
> The new driver is getting close to completion now and things should
> finally stabilize.

OK - I'm not a major C hacker but I'm trying to get a good feel for the driver with my interest in 802.11b generally.  What seems interesting is that the MacOS software config's the card so that a linux box running managed mode can pick it up easily.  It seems to be the most accesible point to access to infrastructure mode.

I'd like to look into writing stuff for this - as well as potentially some user space stuff for ad-hoc networking.  I probably need some pointers on endian clean programming but just a url/book ref and I'll get stuck in.

Paul

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
