Message-ID: <3BB3890B.FE7E6FEE@mvista.com>
Date: Thu, 27 Sep 2001 16:16:11 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Williams, Kevin M." <kevin.m.williams@marconi.com>
Cc: "'Tom Rini'" <trini@kernel.crashing.org>,
	embarque ppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: minor commproc.h fix
References: <A3E34B558F5CD211B4980008C7A4A99003C58441@sparrow.eng.gilbarco.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Williams, Kevin M." wrote:
>
> Can you please make the following change to the linuxppc_2_4 tree:

Well, this is odd....it's correct in the _devel tree......

I don't use the 2_4 tree, so if someone could verify and fix
this (Tom? :-).

> 3 is odd parity, 2 is even. See page 22-14 of the MPC850 user's manual.

Actually 0 is odd parity, 2 is even.  The code will either set or
clear this bit depending upon the serial port settings requested.


	-- dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
