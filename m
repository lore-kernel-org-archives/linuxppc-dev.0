Message-Id: <199910071350.PAA00412@piglet.cpu.lu>
Date: Thu, 7 Oct 1999 15:50:14 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: busmaster/latency for video
To: ran@krazynet.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19991006225426.A192@gondolin.asf>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   6 Oct, this message from Ryan Nielsen echoed through cyberspace:
> 
> PCI_COMMAND_MASTER is not enabled and latency = 0 for the ultimate rez video card, and pci_write_config_*
> do not change them. latency = 32 and mastering is enabled for all the other cards in the machine,
> 
> should they be enabled ?

That probably means the card doesn't support them.

Normal graphic cards have no need for mastership. Only those with video
inputs need it, in order to transfer video data into the framebuffer
without CPU help.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
