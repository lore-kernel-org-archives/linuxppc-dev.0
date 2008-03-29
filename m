Return-Path: <mh@omnisys.se>
Received: from mail.omnisys.se (static-213-115-84-26.sme.bredbandsbolaget.se
	[213.115.84.26]) by ozlabs.org (Postfix) with ESMTP id 37AA8DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Mar 2008 23:54:18 +1100 (EST)
From: "Magnus Hjorth" <mh@omnisys.se>
To: "'git'" <git@xilinx.com>
Subject: Xilinx LLTEMAC driver issues
Date: Sat, 29 Mar 2008 13:54:15 +0100
Message-ID: <003001c8919b$fe9e6150$fbdb23f0$@se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm having some networking troubles with the Xilinx LLTEMAC driver from =
the
Xilinx Linux git tree (powerpc arch) on an ML403 board. EDK9.2SP2,
xps_ll_temac v1.00.b=20

The weird thing is, that it sort of half works. It successfully makes a =
DHCP
request and gets its IP address. I tried setting up a tftpd server, and =
I can
see UDP requests coming in but the response doesn't seem to come out. I =
also
tried running a TCP server on the board, and it can see and accept =
incoming
connections but after that no data seems to get through. I can ping out =
and
get around 40% packet loss.

Looking at /proc/interrupts, I can see both TxDma interrupts and RxDma
interrupts. No eth0 interrupts but that seems to be OK judging by the =
driver
source comments. Ifconfig shows no collistions, no dropped packets, no =
errors,
so the system seems to think that everything is OK.=20

Clues anyone? I'm starting to run out of ideas...

Best regards,
Magnus


--

Magnus Hjorth, M.Sc.
Omnisys Instruments AB
Gruvgatan 8
SE-421 30  V=E4stra Fr=F6lunda, SWEDEN
Phone: +46 31 734 34 09
Fax: +46 31 734 34 29
http://www.omnisys.se
