From: Graf Alex <alex.graf@siemens.com>
To: "'Steven Scholz'" <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <791B3205DB661A42B4BFE5464A7D1D0204B36E24@chzugexch01.abatos.com>
Subject: AW: IDE, PCMCIA and MAX_HWIFS... ?
Date: Mon, 29 Mar 2004 09:52:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


With one Slot (Card) you have to set MAX_HWIFS to 1.

Alex

-----Ursprüngliche Nachricht-----
Von: Steven Scholz [mailto:steven.scholz@imc-berlin.de]
Gesendet: Donnerstag, 25. März 2004 18:00
An: LinuxPPC
Betreff: IDE, PCMCIA and MAX_HWIFS... ?



Hi there,

if I have one IDE interface on my embedded PPC board and I might use a PC
Card HDD in the PCMCIA socket, then do I have to override the define
MAX_HWIFS with 1 or 2 ?

So do I need some kind of a place holder for the IDE interface that might
appear via PCMCIA Card service?

Thanks a million.


--
Steven Scholz

imc Measurement & Control               imc Meßsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
