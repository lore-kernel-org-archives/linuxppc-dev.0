Message-Id: <199910081759.TAA00313@piglet.cpu.lu>
Date: Fri, 8 Oct 1999 19:59:31 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: busmaster/latency for video
To: bh40@calva.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19991008121823.016009@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   8 Oct, this message from Benjamin Herrenschmidt echoed through cyberspace:
> On Thu, Oct 7, 1999, Michel Lanners <mlan@cpu.lu> wrote:
> 
>>Ah, but in that case Apple's OF should enable bus mastering. If I read
>>well between the lines of Apple's docs, OF should set a few default
>>parameters on all PCI devices, among which bus mastering. I'm not sure
>>about latency, though...
> 
> OF tends to ignore devices that don't have an OF expansion ROM. (For
> example, it won't enable memory or IO accesses in the command register).
> I beleive it won't enable bus mastering neither but I may be wrong.

OF itself doesn't enable any memory or IO region; it's the
device-specific init code (which might be on-board for PCI cards, or in
OF for motherboard devices).

There are, however, a few things OF does for _every_ PCI device, among
which enabling bus mastering and assigning memory and/or IO resources.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
