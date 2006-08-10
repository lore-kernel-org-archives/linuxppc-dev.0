Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 9329567B64
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 05:00:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Debugging with no serial port
Date: Thu, 10 Aug 2006 12:00:08 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE487105FD1342@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "Frank" <frannk_m1@yahoo.com>,
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

=20
>> Second question would be - is there an easier way to accomplish what=20
>> I'm trying to do, which is basically emulate a serial port with GDB.

>=20
> Use NetConsole or remotey log it with syslog...
>=20

I guess I wasn't clear in the problem statement - this target doesn't
have a serial port, an ethernet port, or a file system.  So I can't log
over Ethernet or log by writing to a file.  I'm fairly restricted to
getting data out of the system using GDB controlling a hardware JTAG
debugger (think BDI2000).

Tim
