Message-ID: <BE1C564723B3D21191FD0000F840E39801D814EC@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Interference between SCC serial and ethernet
Date: Tue, 2 May 2000 17:48:18 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have the MontaVista 2.2.13 kernel running on my board.
SCC1 for Ethernet; SMC1, SMC2, SCC2 & SCC3 as serial ports.

The SCC serial ports work fine for me, until I use Ethernet. Then, the SCC
serial ports don't work anymore but Ethernet does. The SMC serial ports
continue to work.

I'll be debugging this tomorrow in detail, but I first want to know whether
I should be looking for uart.c/enet.c bugs or limit myself to configuration
issues.  Has anyone used SCC serial ports and SCC Ethernet simultaneously?
If so, I'll concentrate on the config issues.

Thanks, all!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
