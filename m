Message-Id: <199909131813.UAA00324@piglet.cpu.lu>
Date: Mon, 13 Sep 1999 20:13:31 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1
To: ldl@chpc.utah.edu
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <37DBDBB6.4B608A42@chpc.utah.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  12 Sep, this message from Lou Langholtz echoed through cyberspace:
> If I had a spare PowerMac 7500 I'd love to test every combo and see what gets
> detected where. Unfortunately I don't, but hope someone else can do this
> instead and get conclusive info that we need. It concerns me too that people
> with 8500's (that seem to have the same graphics card) seem to observe
> different behavior in detection.

Yeah; might prove interesting to compare the results on a 7500 with
those on a 8500...

> What version of controlfb are you using? Current from the 2.2 kernel tree,
> 2.3 kernel tree, or 2.2 or 2.3 from vger, or even somewhere else. 2.2.12
> wouldn't detect all 4MB VRAM in my 7500 box. I'm sorry but I haven't kept up
> very well with all the different distributions of source. Let me know which
> release then you use and I'll eagerely check it out ;-)

Hmm... official 2.2.12 does detect my 4 MB... and this is a 7600, so
the same motherboard as the 7500...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
