Mime-Version: 1.0
Message-Id: <v04220801b50b5ffb1073@[10.0.0.42]>
In-Reply-To: <1004_2353_954419704_1@agnus>
References: <1004_2353_954419704_1@agnus>
Date: Sat, 1 Apr 2000 00:17:14 -0800
To: Giuliano Pochini <pochini@agnus.shiny.it>, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: G4-PCI
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:35 PM +0200 3/30/00, Giuliano Pochini wrote:
>I could buy a second-hand G4 and I would like to know if latest
>kernel releases sopport that machine. Does ethernet, usb, sound, X, all
>work with 2.2.14 ?
>It seems to ba an early G4 with only PCI slots, no AGP (I will be more
>precise when I'll receive an answer fron the guy which sells the computer=
>).

If it's the PCI only G4, support should be fairly complete, with the
exception of USB and FireWire (IEEE1394).  USB isn't complete in
2.2.x no matter what you do, and 1394 support isn't in 2.2.x at all.

The PCI only G4 uses exactly the same motherboard as the
Blue-and-White G3 minitower.  The only difference is that they didn't
put in an ADB connector and it has a G4 CPU installed instead of a
G3.  That means that any information you can find about running on
the B&W G3 will apply equally well to the PCI G4.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
