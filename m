Message-ID: <3A9564BC.D8C08CA5@mvista.com>
Date: Thu, 22 Feb 2001 14:13:00 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: jtm@smoothsmoothie.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 console problems
References: <20010222082318.71ACE281D9@denx.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> It  seems  you  forgot  to  modify   the   "bd_info"   structure   in
> "include/asm-ppc/est8260.h""  to  match  the  definition as passed by
> PPCBoot.

...and you will have to modify arch/ppc/mbxboot/embed_config.c because
the 8260 may not expect a boot rom to hand it a bd_info.  I don't
remember how I left it......it may just fill in some hard coded values.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
