To: =?iso-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC5200 PCI questions 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 16 Jun 2004 11:30:07 +0200."
             <42A622EB18325843894BB8E1040E3DF502274E@sinaexchf>
Date: Wed, 16 Jun 2004 12:54:22 +0200
Message-Id: <20040616105427.E7321C13D3@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <42A622EB18325843894BB8E1040E3DF502274E@sinaexchf> you wrote:
>
> Is it possible, with the present version of BestComm, to use DMA for IDE and PCI at the same time?

Yes. We've been testing for example with an EEPRO100 network card  to
avoid the known conflicts with the FEC.

> As is not possible to use IDE DMA and the integrated FEC at this moment, I'm thinking of using the integrated ATA controller in the MPC5200 with DMA for an IDE disk and the PCI controller to interface to a PCI to ethernet transceiver in a custom board.
> Is this possible? Any recommended transceiver to use with linux and the MPC5200?.

Yes, this should work. We use the EEPRO100 a lot.

> Also, I would like to know if there is a known to work PCI ethernet card (10/100 if possible) for use with the Lite5200 kit, supported by linux.

Most cards should work just fine.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Programmer's Lament: (Shakespeare, Macbeth, Act I, Scene vii)
        "That we but teach bloody instructions,
        which, being taught, return to plague the inventor..."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
