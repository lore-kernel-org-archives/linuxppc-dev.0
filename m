Message-ID: <3BC5D333.E47A9975@mvista.com>
Date: Thu, 11 Oct 2001 13:13:23 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: laurent.pinchart@capflow.com
Cc: linuxppc-embedded@lists.linuxppc.org, wd@denx.de
Subject: Re: FEC on MPC860T & race condition
References: <3BC58BE6.8000302@capflow.com> <3BC5B2F6.8000705@capflow.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Laurent Pinchart wrote:

> At boot time, bit 17.1 is not set, and thus the FDS/MDINT signal is low
> when the network cable is disconnect. The PHY interrupt handler gets
> registered when fec_enet_init() is called, and thus spurious interrupts
> are generated and the kernel freezes.....

You may want to try later versions of the kernel before posting bugs.
This has already been fixed......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
