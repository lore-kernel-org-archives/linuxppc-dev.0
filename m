Message-ID: <3B66FBB1.B1239FFC@mvista.com>
Date: Tue, 31 Jul 2001 14:40:49 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Pergola, Michael" <MichaelPergola@Danfoss.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"Support (E-mail)" <techsupport@embeddedplanet.com>
Subject: Re: SCC character recognition/DMA
References: <E1836A7F3557D311A14000805F9F36FCD4E3DC@usdfo011.usac.danfoss.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Pergola, Michael" wrote:

> Has anyone attempted to utilize the character-recognition
> feature of the SCC ports with any success?

Yes, it does work, just make sure you have an SCC to use (there
is only one on the 823, which is typically wired for Ethernet).

> ...... but I
> don't see if DMA is used to shuttle data to/from the serial
> ports. Has that been attempted?

The DMA must be used.  It is the only way the CPM moves data to/from
the devices.  There is no programmed I/O to 8xx peripherals except
the GPIO pins.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
