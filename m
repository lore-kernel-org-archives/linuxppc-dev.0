Message-Id: <199910071913.VAA00361@piglet.cpu.lu>
Date: Thu, 7 Oct 1999 21:13:03 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: busmaster/latency for video
To: Geert.Uytterhoeven@sonycom.com
cc: ran@krazynet.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.10.9910071606120.24804-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   7 Oct, this message from Geert Uytterhoeven echoed through cyberspace:
> On Thu, 7 Oct 1999, Michel Lanners wrote:
>> On   6 Oct, this message from Ryan Nielsen echoed through cyberspace:
>> > PCI_COMMAND_MASTER is not enabled and latency = 0 for the ultimate rez video card, and pci_write_config_*
>> > do not change them. latency = 32 and mastering is enabled for all the other cards in the machine,
>> > 
>> > should they be enabled ?
>> 
>> That probably means the card doesn't support them.
>> 
>> Normal graphic cards have no need for mastership. Only those with video
>> inputs need it, in order to transfer video data into the framebuffer
>> without CPU help.
> 
> Many recent graphics chips to support bus mastering, especially the AGP ones.

Ah, but in that case Apple's OF should enable bus mastering. If I read
well between the lines of Apple's docs, OF should set a few default
parameters on all PCI devices, among which bus mastering. I'm not sure
about latency, though...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
