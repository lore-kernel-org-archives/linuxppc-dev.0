From: Sorin Balea <sorin@nitechinc.com>
Reply-To: sorin@nitechinc.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE on MBX board
Date: Mon, 22 Nov 1999 11:22:11 -0500
Content-Type: text/plain
References: <99111909331400.01435@splash.nitechinc.com> <38397383.8F8677A1@jlc.net>
In-Reply-To: <38397383.8F8677A1@jlc.net>
MIME-Version: 1.0
Message-Id: <99112211371500.00831@splash.nitechinc.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 22 Nov 1999, you wrote:
> The IDE has assumed knowledge of PC-style addresses and behavior.  To
> use things like ATA Flash cards in the PCMCIA of the 8xx, I break the
> generic IDE interface.  On the 8xx, it is also sensitive to the interrupt
> controller.  Cort and I are always going back and forth about how to
> use the internal interrupt controller in combination with the external
> 8259.  I want things that are more generic to other 8xx boards, and to
> get IDE to work you have to make assumptions unique to the MBX.
> 
> I understand it would be nice to have the IDE working on the MBX, but
> all of the products I have worked with use ATA flash....nothing has
> ever used an IDE drive through a PCI/AT bus adapter.  This is why code
> I tend to check in will allow PCMCIA ATA Flash and not the more complex
> external IDE.....it represents products in the field.

So from what i understand, the IDE on MBX board is done by the W83C553F 
chip which i suppose it's not present on other boards, am i right? 
If nobody minds, i'd like to give it a shot at making it work, even if it's
MBX specific... i could really use a hard drive on my board

So, any hints about where to begin?
Right now i'm using 2.2.13. It seems to initialize the IDE interface, but the
drive is not detected.
I'm thinking about using 2.3.28, it seems to have more support for this kind of
stuff, but it's a mess when it comes to building the kernel...

Cheers
Sorin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
