Message-ID: <B164B53F5BD6D511888D009027732E1A0249C6@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Software update for BDI2000
Date: Wed, 19 Dec 2001 16:49:26 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all

Just to let everyone know that new software is available for bdi2000. Most
of you probably got an e-mail from Abatron. If you did not install it -- do
it now. One of the things it gives you is routing of target serial through
to the telnet session. No more running from your PC to the target machine to
see what is happening on console!
just add line
SIO   7 9600    ; 7 -- telnet port, 9600 baud rate

in the [TARGET] section of the bdi2000 config file, connect target serial to
the bdi2000 service port and reboot bdi2000.

Then, on your machine run

telnet <bdi2000 ip> 7

and it all works!

/************************/
Rudolf Ladyzhenskii
DSP Engineer
Advanced Communication Technologies
ph.  +61 3 8080 8215
fax. +61 3 9672 8800
Level 9, 190 Queen Street,
Melbourne, 3000
Australia
/***********************/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
