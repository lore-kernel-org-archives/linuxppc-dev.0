Message-ID: <38791AAD.F3EBA3A2@netx4.com>
Date: Sun, 09 Jan 2000 18:33:01 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Dan Dickey <ddickey@charter.net>
CC: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MPC850 Development Board - with SDRAM
References: <38777E93.2BE51FEE@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Dickey wrote:

> yes - I have an RPX Lite sitting right next to me.
> But, apparently Embedded Planet doesn't have any
> development boards with SDRAM on them.


Embedded Planet does not build development boards, they
build production boards for OEMs to integrate into products
to reduce development cost and risk.  There is always
a debate about EDO versus SDRAM.  Their design started wtih
EDO, and since it continues to be available with both
competitive cost and performance there isn't a reason to
change the design.

Products that wish to use SDRAM do so by placing it on their
boards that connect to the Embedded Planet board.  This allows
the flexibility to add the necessary amount of memory for
the product requirements.  You can use the UPMB signals from
the RPX-Lite processor bus connector in your design if you
require SDRAM.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
