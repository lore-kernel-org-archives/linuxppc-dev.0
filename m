From: "Dan Jankins" <DJankins@communica.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8240 built in uart??
Date: Mon, 27 Nov 2000 16:00:54 -0500
Message-ID: <NEBBKDMDALNLPJILFLLOAEBHCAAA.DJankins@communica.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All, It appears that the MPC8240 has and UART build into it.  The PCI
Clock's signals (PCICLK0,1,2,3, pins AC25,AB25,AE26, AF25) are dual
function.  I have a Sandpoint Dev Board and there is a MAXIUM RS-232 driver
connected to these pins on the daughter.  This would make it the third
RS-232 port.  This port is not brought out to a external connector, only to
J5 on the daughter board.

Daniel R Jankins


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
