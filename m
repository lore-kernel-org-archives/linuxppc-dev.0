Return-Path: <kjoutwater@raytheon.com>
Received: from tus-mailout1.ext.ray.com (tus-mailout1.raytheon.com
	[199.46.245.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93EDC67C25
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 09:04:04 +1000 (EST)
Received: from dmoutt00.directory.ray.com (dmoutt00.directory.ray.com
	[147.25.154.125])
	by tus-mailout1.ext.ray.com (Switch-3.2.2/Switch-3.2.2) with ESMTP id
	k7MN3tpQ021183
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Aug 2006 23:03:56 GMT
Received: from dmsmtpt00.directory.ray.com (dmsmtpt00.directory.ray.com
	[147.25.154.118])
	by dmoutt00.directory.ray.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id
	k7MN3fdG005577
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 23:03:56 GMT
Received: from tu2-msg04.rsc.raytheon.com (tu2-msg04.RSC.RAYTHEON.COM
	[147.24.232.105])
	by dmsmtpt00.directory.ray.com (8.12.11/8.12.11) with ESMTP id
	k7MN3cVe005122
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 23:03:38 GMT
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: MontaVista 2.4.30 kernel support for bus error status registers on
	Xilinx VirtexIIPro?
From: Keith J Outwater <kjoutwater@raytheon.com>
Message-ID: <OF0EE1EA67.FF5C86BD-ON072571D2.007E18A0-072571D2.007EBB51@mck.us.ray.com>
Date: Tue, 22 Aug 2006 16:04:21 -0700
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I am running a 2.4.30 kernel rsynced from Monta Vista on a Xilinx 
VirtexIIPro FPGA.
My design includes a PLB2OPB (Processor Local Bus to On chip Peripheral 
Bus) bridge that is
capable of generating a bus error interrupt when an OPM slave device 
asserts it's bus error
signal.  The PLB2OPB bridge also has a set of "bus error status and 
address registers"
that are capable of capturing information regarding the type of error that 
occurred.

Has anyone implemented support  for this functionality in a 2.4.x kernel 
running on
VirtexIIPro FPGAs?


Thanks!
Keith
