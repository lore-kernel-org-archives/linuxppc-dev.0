Date: Wed, 8 Mar 2000 14:14:19 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: enneper@gmx.net
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Booting 2.3.48 (devel) kernel problems?
In-Reply-To: <20000308133433.A440@gmx.li>
Message-ID: <Pine.LNX.4.10.10003081413470.13091-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  Michael Schmitz }  That, plus a few patches related to BootX text console output happening
>  Michael Schmitz }  before the framebuffer is mapped. I'll dig out a patch if necessary.
>
> PB3500 as mentioned could be booted via OF.

So the framebuffer got mapped from OF but not from BootX.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
