Message-ID: <3B7AA722.14577224@mvista.com>
Date: Wed, 15 Aug 2001 12:45:22 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Cindy Peters <cinpet@adaptivemicro.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA/IDE transfer rates
References: <41EDEC3C1B88D51186EB00A0C9CFADF702FA44@AMWMAIL>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cindy Peters wrote:
>
> Does anyone know approximately what the transfer rates (peak and
> sustainable)  would be for a PCMCIA/IDE hard disk on an MPC823?

Ummm...slow :-).

It's all programmed I/O, so it depends upon the PCMCIA timing and
the capability of the disk.  People I have talked to that use this
configuration were never concerned about the speed, but rather needed
the additional storage space.  It certainly isn't workstation/server
performance :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
