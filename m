Message-ID: <3AB92D14.A7157038@mvista.com>
Date: Wed, 21 Mar 2001 17:37:08 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Curry, Diane" <dcurry@infiniswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hardhat Linux 2.4.2 on IBM Walnut w/AMC ICE
References: <FF6CF34C346E724596A2FB5CAAB2C49707F90D@voyager.ops.infiniswitch.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Curry, Diane" wrote:
>
> Hi Everyone,
>   I'm running Monta Vista's 2.4.2 source release on an IBM rev D Walnut
> along with AMC's PowerTap (jtag interface) and MWX-ICE software.

You are going to need a debugger that understands MMUs.  The only
one I can recommend (and that works very, very nice) is the Abatron
BDI2000 with a Linux/GDB host.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
