Date: Thu, 24 Jan 2002 11:03:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: hollis@austin.ibm.com
Cc: linuxppc-dev@lists.linuxppc.org, sdi@remote.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: RFC: vesafb
Message-ID: <20020124180313.GB1839@cpe-24-221-152-185.az.sprintbbd.net>
References: <20020123192010.GP510@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020123192010.GP510@austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 23, 2002 at 01:20:10PM -0600, hollis@austin.ibm.com wrote:

> The attached patch allows vesafb to work on PPC. vesafb does surprisingly
> little with the BIOS (which I thought was the whole point of VESA). With some
> ifdef's I'm able to use it as sort of a VGA offb -- the firmware initializes
> the card, and the driver just uses it and never mucks with it.

This looks good to me.  My only comment is you should probably use
CONFIG_MTRR around the mtrr bits instead of __i386__ (which is what
other drivers do).  Geert, since you're still overall fb maintainer
(yes?) would you be willing to sign off on these changes to be sent to
Marcelo for 2.4.19-pre1?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
