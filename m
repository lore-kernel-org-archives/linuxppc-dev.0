From: "Gunther Brau" <gunther.brau@tz-mikroelektronik.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC850: Ethernet on SCC3
Date: Tue, 22 Aug 2000 16:31:36 +0200
Message-ID: <001301c00c45$ad649220$28706c86@tepc42.tz-mikroelektronik.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everyone,

Here my Service Request to MOTOROLA:
----------------------------------------------------------------------
System description:
In our product we would like a Ethernet port at the SCC3-Channel
("SCC1"=USB; SCC2=IrDA). The appropriate control signals /CD3
("RENA"=PC4) and /CTS3 ("CLSN"=PC5) of the Transceiver
(LXT905/LevelOne) have to be configured with the the bits 6 and 7
in the Special option register PCSO ("MPC850 User's manual" page 34-15).

Problem/Solution description:
Register PCSO must be initialized however definitely with 0x0C00
(reserved bits 4 and 5 are set!), thus it does not come to a transfer error
("Carrier sense lost" = no RENA or CLSN signal) !

My question:
How can this be? Is in the "MPC850 User's manual" a misprint? I had expected
to configure the Register PCSO according to User's manual with 0x0300!
By the way: With this configuration and with a MPC860 the control signals
/CD4 and /CTS4 would be configured (but there is no SCC4 in MPC850).
It would be very grateful, if you could check this circumstances.
----------------------------------------------------------------------

Here the answer from MOTOROLA DigitalDNA Help:
----------------------------------------------------------------------
Dear Gunther Brau,

In reply to your Service Request SR 1-V7U2 (see details below):

It's UM errata on page 34-15, figure 24-14.  CD3 and CTS3 are PC 4 and PC5,
respectively.(fp)
CD3 is Port C4 and CTS3 is Port C5.
----------------------------------------------------------------------
(Ok, an exact question does not always result in an exact response....)


Hope, that will help someone.


Mit freundlichen Grüßen
       (Best regards)
       Gunther Brau


Transferzentrum Mikroelektronik, Göppingen

Dipl.-Ing. (FH) G. Brau
Entwicklung  (Development)

Robert-Bosch-Straße 1
D-73 037 Göppingen
Phone: +49 (0 71 61) 679 -212
Fax:   +49 (0 71 61) 679 -245
e-Mail: mailto:gunther.brau@tz-mikroelektronik.de
visit our website on http://www.tz-mikroelektronik.de


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
