Subject: Re: 8xx Microcode patch
From: Albert ARIBAUD <albert.aribaud@free.fr>
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3EFE94E4.90905@austin.rr.com>
References: 
	<30C145E544071F4FB8B627789F7910BD328FF3@csy-exchange1.giat.intra>
	<3EFE94E4.90905@austin.rr.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: 29 Jun 2003 10:53:49 +0200
Message-Id: <1056876830.2737.7.camel@lilith.aribaud.fr>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Le dim 29/06/2003 à 09:27, Jeff Hurst a écrit :
>
> On the MPC860 page (the MPC855T is a family member) at Motorola web site:
> MPC860MC04  MPC860 Microcode Patch for Relocating I2C/SPI Parameters
> (03/06/2002)  contains a pdf.  It says 0502 is the last mask needing
> the microcode.

Thanks a lot for your answer. I read the pdf, which confirmed that
microcode only fixes I2C/SCC1 Ethernet as well as SPI/SCC2 Ethernet
overlay. However this is not my current I2C problem (which I'll state in
another thread), as my MPC855T has no SCC2 and its SCC1 is in UART mode.
:(

Thanks again,

Albert.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
