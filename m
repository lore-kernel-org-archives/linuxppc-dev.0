Message-ID: <3D6D5D15.9060300@mvista.com>
Date: Wed, 28 Aug 2002 16:30:29 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Sanjeev Manral <sanjeevm@sanyo.co.in>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pcmcia- config.opts, cis and pci
References: <6DF87017DA95D611AC6000606730DE9B0BD764@BLREXSR>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sanjeev Manral wrote:

>Hi all,
>
>I'm using pcmcia-cs-3.2.0 my kernel is 2.4.17. It's a ppc405 board.
>
>pcmcia-cs is not able to detect ide_cs card and telling it a Blank card.
>
>I've tried many options in /etc/pcmcia/config.opts but nothing is working.
>
>I'm having one more doubt. there is no PCI brige in manual of my hardware.
>It is using coreconnect architecture and PCMCIA controller is directly
>connected to processor local bus. In hardware there is not a single mention
>of pci-plb bridge.
>
well, you probably need to write a socket driver for your on-chip pcmcia
controller.

>
>
>If I disable "pci" in "make xconfig" "card bus support" is also disabling
>and there are no sockets.
>shall I enable "pci" and "card bus support"( I'm trying this, IS IT
>CORRECT?)
>
>I debugged it with enable "pci" and "card bus support". driver is not able
>to get a valid cis. and trying to load a blank card driver( memory_cs )
>instead of ide_cs.
>
>Is it a problem with only config.opts or some other problem.
>
>I don't know where to proceed. if somebody knows how and where to get a
>valid config.opts please let me know.
>
>thanks,
>Sanjeev
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
