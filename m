Message-ID: <007d01c102fd$5fe502f0$a66d34c0@zaz>
From: "Lionel TAILLURAT" <lionel.TAILLURAT@ecrin.com>
To: "ppc_mailing_list" <linuxppc-embedded@lists.linuxppc.org>
Subject: MVME 5100 & Linux
Date: Mon, 2 Jul 2001 15:46:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear,

I'm trying to install the Debian PPC Linux 2.2R0 on an MVME5100 + MVME 761 +
IPMC 761.

For that I download the Prep Image by TFTP, and the only thing I have is :

PPC6-Bug>nbo
Network Booting from: I82559, Controller 0, Device 0
Device Name: /pci@fe000000/pci8086,1209@e,0:0,0
Loading: bootfull.bin

Client IP Address      = 192.52.109.200
Server IP Address      = 192.52.109.166
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = bootfull.bin
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&2069854, Bytes Loaded =&2069854
Bytes/Second   =&1034927, Elapsed Time =2 Second(s)

Residual-Data Located at: $03FA137C


I have seen in the Mailing list archive that there was some problems using
Linux with the MVME 5100 and especially with the residual data.

Is there is a correction of this problem ?

What should I do to have Linux working with this board ?

Thanks in advance.

Lionel

--

+----------------------------+-------------------------+
| Lionel TAILLURAT           | ECRIN AUTOMATISMES      |
| TECHNICAL SERVICE          | Rue du pré-de-l'Horme   |
|                            | B.P 15                  |
| Tel :(33) 4 76 92 20 01    | 38921 CROLLES CEDEX     |
| Fax :(33) 4 76 08 03 18    | FRANCE                  |
|                            | http://www.ecrin.com    |
+----------------------------+-------------------------+
|Email: Lionel.TAILLURAT@ecrin.com                     |
|Email: support@ecrin.com                              |
+------------------------------------------------------+


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
