Message-ID: <3E315EFC.7080600@imc-berlin.de>
Date: Fri, 24 Jan 2003 16:42:52 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] m8xx_setup.c and PCMCIA
References: <3E30F363.1020501@imc-berlin.de> <3E3157BF.7060804@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:


> Well, _almost_ isn't good enough :-)
Fair enough!

> I hope some of the more PCMCIA literate folks speak up here, because I
> think placing IO_BASE into the mix, and certainly io_block_mapping it
> is quite wrong.  It may be necessary for your board, but it certainly
> isn't something that is going to work on many others.  All you need is
> an 860 with a Tundra PCI bridge and all of these patches will fail to work.

Well, that's why "&& !defined(CONFIG_PCI)"... Or?

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
