Message-ID: <3A6862D3.C23165B2@mvista.com>
Date: Fri, 19 Jan 2001 10:52:51 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Francois Tremblay <francois.tremblay@ieee.org>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel on MPC850FADS
References: <200101191515.KAA04626@hermes.usherb.ca>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Francois Tremblay wrote:

> The ILAP_ADDRESS refer to NVRAM of MBX and is not exist on a FADS board.
>
> Someone know to fix this problem?

There isn't anything to fix.  You are using a FADS board, not an
MBX.  Don't configure for an MBX and expect it to work on something else.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
