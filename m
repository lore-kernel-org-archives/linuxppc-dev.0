Message-ID: <37D0F88E70D96C428C19EEB865701A3801DC62E6@buda902a.siemens.hu>
From: =?ISO-8859-1?Q?M=E9sz=E1ros_Lajos?= <ludwigm@siemens.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: SCC as serial console on 8260
Date: Thu, 6 Nov 2003 15:12:49 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Can we use the SCCs as console on 8260
based boards? (2.4.18 and 2.4.22)

1. The arch/ppc/8260_io/uart.c initializes
(near) all port in the
	"int __init rs_8xx_init()"
but in the kernel early phase the
	"static int __init serial_console_setup()"
doesn't. (the SMCs only)

2. With the U-boot as loader the setting of the
port bits is unnecessary (I think). The case
of "enet.c" and "fcc_enet.c" is the same.

	Ludwig
_____________________________________
Mészáros Lajos
Siemens  Hungary
SIEMENS Information and Communication Networks
ICN D XDSL
1143 Budapest, Gizella u. 51-57.
Hungary
Fax: +36 1 471-2222
E-mail: mailto:ludwigm@siemens.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
