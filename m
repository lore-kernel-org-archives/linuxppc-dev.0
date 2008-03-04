Return-Path: <mh@omnisys.se>
Received: from mail.omnisys.se (static-213-115-84-26.sme.bredbandsbolaget.se
	[213.115.84.26]) by ozlabs.org (Postfix) with ESMTP id D9D96DDE42
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Mar 2008 21:27:41 +1100 (EST)
From: "Magnus Hjorth" <mh@omnisys.se>
To: <linuxppc-embedded@ozlabs.org>
Subject: Xilinx git tree, LLTemac driver
Date: Tue, 4 Mar 2008 10:57:42 +0100
Message-ID: <000f01c87dde$30ee1460$92ca3d20$@se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: git@xilinx.com
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

I'm trying to compile the Linux kernel from the Xilinx git tree
(linux-2.6-xlnx) and am having some trouble with the LLTemac driver, =
having
to do with MAC address settings.=20

There seems to be two routines getting the MAC address in different =
ways.
The xtenet_probe function tries to access an extern bd_t __res, the type
bd_t doesn't exist in the powerpc tree which causes the compilation to =
fail.
Then there is the xtenet_of_probe function which uses =
of_get_mac_address.

What confuses me is that both the regular and the OF driver is =
registered in
the xtenet_init function, I would have expected it to be either/or.=20

Can I expect under the powerpc arch and supplying a .dts file, that the
xtenet_probe function will never be called?=20

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
