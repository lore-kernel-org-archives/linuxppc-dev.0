Date: Mon, 24 Jul 2000 16:43:35 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: John Grimes <jpgrimes@johngrimes.dyndns.org>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86 version 4.01
In-Reply-To: <Pine.LNX.4.21.0007241035230.1920-100000@johngrimes.dyndns.org>
Message-ID: <Pine.LNX.4.10.10007241641090.6367-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 	Yes i have 2 video cards, I have the pci rage128gl and the
> internal (platinum I think) video that comes with all powercenters.  An
> lspci does not show the internal video.  Could this be a kernel build
> config issue?  I thought I included support for the internal apple
> video.  I off course have this working in the MacOS.

This probably means Apple didn't assign the platinum chip a separare bus
ID and function code. I couldn't find any trace of PCI code in platinumfb
so I guess you need to use fbdev there which should fall back to opening
/dev/fb? devices if no bus ID is known.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
