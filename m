Subject: Re: radeonfb: PLL? problems with radeon 7000 in embedded PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matevz Langus <matevy@arhitektova-delavnica.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1080771003.6224.14.camel@localhost.localdomain>
References: <1080771003.6224.14.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1080788741.1416.54.camel@gaston>
Mime-Version: 1.0
Date: Thu, 01 Apr 2004 13:05:41 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-04-01 at 08:10, Matevz Langus wrote:

> Has anybody managed to use this card in embedded system without BIOS or
> OF?

You cannot use such a card if it has not been properly initialized
by the firmware first. One solution is to use an x86 emulator to
run the x86 BIOS. If you are building embedded applications with
on board chipsets, ATI would probably have provided you with the
necessary init code.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
