Message-ID: <39235DE0.585F036A@embeddededge.com>
Date: Wed, 17 May 2000 23:05:04 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Pavel Roskin <pavel_roskin@geocities.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Another useful piece of code lost
References: <Pine.LNX.4.21.0005171815010.32437-100000@sunapee.transcept.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pavel Roskin wrote:

> Strictly speaking, this is wrong because this code assumes that all PPC
> machines, even PowerMac's use PCMCIA.

Of course it's wrong.  That was done specifically for your custom
embedded hardware.  There wasn't any mechanism in that code base to
ack the ATA interrupt if it didn't come from known IDE hatdware.

> The MontaVista kernels don't include anything like that. This is one of
> the reasons why they don't support ATA Flash on RPX/Lite.

That work was done for you under contract on the RPX-Lite.  If you wish
to give this away, go ahead.  My intention is to use newer IDE abstractions
or Magnus' real PCMCIA instead of this unique solution for you.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
