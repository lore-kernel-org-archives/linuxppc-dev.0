Message-Id: <200004242111.XAA00393@piglet.grunz.lu>
Date: Mon, 24 Apr 2000 23:11:19 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: aty128 and offb and linux-2.3.99pre6
To: drow@false.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000424150752.A25359@drow.res.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  24 Apr, this message from Daniel Jacobowitz echoed through cyberspace:
> On Mon, Apr 24, 2000 at 08:51:12AM +0200, Michel Lanners wrote:
>> control is only PCI-based with some abstractions.... It can, however,
>> be made to look entirely like a PCI device, if you can avoid poking at
>> it afterwards.
>>
>> I have patches for control anyway (adding it to the PCI device chain,
>> precisely); so I might try and implement the changes for control. Or
>> are you already working on this, Dan?
>
> I've been too busy with Debian to touch controlfb lately; patches would
> be appreciated.

I'll see what I can do ;-)

> Also, what is the current state of your memory testing?  Or was that
> not you?

Yes, that was me. I got some reports, but I couldn't conclude anything
out of them. I still haven't found a way to identify the VRAM config in
all cases... We might need to do two different detections, based on the
board type: 7x00 (TNT) or 8x00 (Nitro); but I have no idea how to
differentiate them except by looking for additional device(s) in the
device tree (Sixty6, video out?).

Or get some info out of Apple, either directly or reverse-engineered....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
