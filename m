Message-ID: <E1836A7F3557D311A14000805F9F36FCD4E3DE@usdfo011.usac.danfoss.net>
From: "Pergola, Michael" <MichaelPergola@Danfoss.com>
To: "'Dan Malek'" <dan@mvista.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: SCC character recognition/DMA
Date: Tue, 31 Jul 2001 15:07:43 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From:	Dan Malek [SMTP:dan@mvista.com]
> Sent:	Tuesday, July 31, 2001 2:41 PM
> To:	Pergola, Michael
> Cc:	'linuxppc-embedded@lists.linuxppc.org'; Support (E-mail)
> Subject:	Re: SCC character recognition/DMA
>
> "Pergola, Michael" wrote:
>
> > Has anyone attempted to utilize the character-recognition
> > feature of the SCC ports with any success?
>
> Yes, it does work, just make sure you have an SCC to use (there
> is only one on the 823, which is typically wired for Ethernet).
	[Pergola, Michael]
	The 823e that comes with the Embedded Planet Dev Box
	has 3 SCCs but one is dedicated to USB while another is
	used for Ethernet. I guess my real question is, rather then
	re-invent the code, is there an implementation of the
	character recognition out there in GPL land?

	Michael Pergola

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
