Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 7DC8B67C43
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 10:11:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Debugging tools
Date: Thu, 8 Jun 2006 17:11:45 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE4871054F1FCA@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: <dhlii@comcast.net>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>=20
>     I was hoping to be able to bring up gdb, download an elf file to
the
> target and step through a program to see where it is going off the
rails.
>=20

Assuming you have the Xilinx EDK tools installed, there is a program
called xmd that acts as a standalone debugger or can communicate with
gdb over a socket.

>     A bit of research suggests that there are gdbservers that bridge
> between gdb and JTAG. But all the links I have found to rproxy seem to
> be broken, and those for gdbproxy seem to be
>     for other processors.

EDK builds example programs when you use the BSB.  You can download and
debug these programs as a test.  From EDK 7.1, Tools->Software Debugger.

Tim
