Message-ID: <40631017.1020408@imc-berlin.de>
Date: Thu, 25 Mar 2004 18:00:07 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: IDE, PCMCIA and MAX_HWIFS... ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

if I have one IDE interface on my embedded PPC board and I might use a PC
Card HDD in the PCMCIA socket, then do I have to override the define
MAX_HWIFS with 1 or 2 ?

So do I need some kind of a place holder for the IDE interface that might
appear via PCMCIA Card service?

Thanks a million.


--
Steven Scholz

imc Measurement & Control               imc Meﬂsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
