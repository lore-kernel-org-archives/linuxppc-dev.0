From: Benjamin Herrenschmidt <bh40@calva.net>
To: Bernhard Reiter <bernhard@intevation.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Powerbook hard freeze summary (sort of)
Date: Wed, 24 May 2000 16:49:58 +0200
Message-Id: <20000524144958.10978@mailhost.mipsys.com>
In-Reply-To: <20000524161837.M6396@cheops.usf.Uni-Osnabrueck.DE>
References: <20000524161837.M6396@cheops.usf.Uni-Osnabrueck.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 24, 2000, Bernhard Reiter <bernhard@intevation.de> wrote:

>
>It might as well be a design problem of the Powerbooks. Can any of the
>hardware kernel hackers comments on the differences in architecture
>for powerbooks and the other G3s? Maybe a linux driver is written sloppy
>in this area not taking in account how the hardware actually works?

The Lombard PowerBook uses the same architecture as the first generation
iMacs (and this same memory controller is also used on the beige and B&W
G3s at least). If there is a problem, it's either a memory controller
problem (bogus revision ? incorrect setup ?), or a specific issue with
the design of the memory connector/logic.

The Pismo uses the same chipset as the new iMacs, G4s (sawtooth) and iBook.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
