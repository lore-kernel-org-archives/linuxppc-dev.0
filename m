Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [63.240.77.84])
	by ozlabs.org (Postfix) with ESMTP id 188F767C15
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 09:18:45 +1000 (EST)
Message-ID: <4488ADF0.2030003@dlasys.net>
Date: Thu, 08 Jun 2006 19:08:32 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Debugging tools
References: <200606011700.k51H0WJw014425@www-webmail1.magma.ca>
In-Reply-To: <200606011700.k51H0WJw014425@www-webmail1.magma.ca>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


    I have encountered one of the rare instances where I need/want more
debugging resources than an LED on an IO port.

    I am looking for some recommendations as well as understanding of
the lighter weight debugging tools that are available.
    I am dealing with a Xilinx V4 PPC405  FPGA. It is hosted in a
computer running Windows XP. Aparently there is a JTAG port
    on the device that emulates a JTAG parallel port on LPT3 on the host
side.

    I was hoping to be able to bring up gdb, download an elf file to the
target and step through a program to see where it is going off the rails.

    A bit of research suggests that there are gdbservers that bridge
between gdb and JTAG. But all the links I have found to rproxy seem to
be broken, and those for gdbproxy seem to be
    for other processors.

  
