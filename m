Message-ID: <40E463E5.1060401@246tNt.com>
Date: Thu, 01 Jul 2004 21:20:05 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>,
	kumar.gala@freescale.com, mcclintock@freescale.com
Subject: Re: [PATCH][RFC]Updated MPC I2C driver
References: <1088705955.28598.168.camel@localhost>
In-Reply-To: <1088705955.28598.168.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Adrian Cox wrote:

 > This version should support MPC8540 as well as MPC8245 and MPC107.
 > I don't have MPC85xx hardware, so I'd like feedback from people who
 > do.
 >
 > To use it on MPC107/824x requires the OCP patch that went by on the
 > list on Tuesday. The support for MPC85xx is already in the kernel.
 >
 > If nobody has any complaints I'm ready to send it to Greg K-H.


Interesting, it really looks like the MPC5200 I2C controller.
Unfortunatly :
 - On the MPC5200, all the status/controls bits are in the MSBs ( so
the consts would need to be << 24 )
 - And there is a interrupt control register I don't see in your code.
It's shared by the two I2C controllers onboard.

I'll try to see if I can make it work on the lite5200 board.

Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
