Message-ID: <3AFAC193.F7B1FE96@mvista.com>
Date: Thu, 10 May 2001 12:28:03 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: mschmid@ascona.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Is CONFIG_8xx the right setting for MPC8240
References: <OF6B040367.6AA70D4B-ONC1256A48.003D8A75@ascona.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


mschmid@ascona.de wrote:

> Is it wrong to select CONFIG_8xx for a MPC8240 CPU ?

Yes, it is.....

> I know that the sandpoint board or one of them also uses a MPC8240 but i
> don't know if CONFIG_8xx is used for that sandpoint board.

The 8240 is a CHRP/60x configuration.  Just select a 60x processor,
configure PCI, and your board peripherals.  Use the Sandpoint setup
as an example for your board configuration.  Any 8240 board should
be running Linux in just a couple of hours.........


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
