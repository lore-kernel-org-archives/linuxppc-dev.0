Date: Wed, 8 Nov 2000 20:58:14 +0100 (MET)
From: Tobias Otto-Adamczak <tobias.otto-adamczak@e-technik.tu-chemnitz.de>
To: clark@esteem.com
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: More on my SPI driver questions
In-Reply-To: <5.0.0.25.1.20001108105630.00a4d890@pop.esteem.com>
Message-ID: <Pine.LNX.4.21.0011082047010.13081-100000@pandora.hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I was wondering if anbody has a working SPI driver yet that gets along
> with SCC2 Ethernet?

Adding some lines you should be able to use my code.

> Is there any known side effects IIC/SPI microcode patch?

The I2C/SPI host commands (Init Rx/Tx params, close RxBD) are not
supported when using the patch. Therefore you have to take care of some
register values yourself. There is a Motorola document that explains more
details. I can send you this.

Ciao - Tobias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
