From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ralf Weidemann <linuxppc@gatekeeper.informatik.fh-dortmund.de>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.17-pre8-ben0: kernel oops using pcmcia services
Date: Fri, 14 Dec 2001 17:26:48 +0100
Message-Id: <20011214162648.16316@smtp.adsl.oleane.com>
In-Reply-To: <3C1A21C4.6040607@gatekeeper.informatik.fh-dortmund.de>
References: <3C1A21C4.6040607@gatekeeper.informatik.fh-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I get the below kernel oops after I put my cisco aironet pcmcia card into
>the external slot on my tibook. Kernel bug or wrong setup ? While loading
>the airo_cs module per hand I get no oops.

Looks like it tried to ioremap an ISA memory address, bad bad bad...

Either your memory options in config.opts is wrong or that driver
has a bug.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
