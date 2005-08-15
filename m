Return-Path: <kjoutwater@raytheon.com>
Received: from tus-gate4.raytheon.com (tus-gate4.raytheon.com [199.46.245.233])
	by ozlabs.org (Postfix) with ESMTP id 4CC0367F41
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Aug 2005 08:50:01 +1000 (EST)
Received: from ds02t00.directory.ray.com (ds02t00.directory.ray.com
	[147.25.154.117])
	by tus-gate4.raytheon.com (8.12.10/8.12.10) with ESMTP id
	j7FLu7Lo025523 for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Aug 2005 14:56:07 -0700 (MST)
Received: from ds02t00 (localhost [127.0.0.1])
	by ds02t00.directory.ray.com (Switch-3.1.7/Switch-3.1.0) with ESMTP id
	j7FLu1PL024369
	for <linuxppc-embedded@ozlabs.org>; Mon, 15 Aug 2005 21:56:01 GMT
Received: from ds02t00.directory.ray.com with LMTP by ds02t00
	(2.0.6/sieved-2-0-build-559)
	for <linuxppc-embedded@ozlabs.org>; Mon, 15 Aug 2005 21:56:01 +0000
Received: from tu2-msg04.rsc.raytheon.com (tu2-msg04.RSC.RAYTHEON.COM
	[147.24.232.105])
	by ds02t00.directory.ray.com (Switch-3.1.7/Switch-3.1.0) with ESMTP id
	j7FLtuiA024275
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Aug 2005 21:55:56 GMT
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
From: Keith J Outwater <kjoutwater@raytheon.com>
Message-ID: <OF688E8333.A7E991BA-ON0725705E.00780121-0725705E.00787A39@mck.us.ray.com>
Date: Mon, 15 Aug 2005 14:55:56 -0700
Content-Type: text/plain; charset="US-ASCII"
Subject: Best kernel for Xilinx VirtexII Pro/PPC405 ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all - 
I am designing an embedded system using a Xilinx Virtex II Pro FPGA.
Can anyone point me to the "best" kernel source tree to use ?
"Best" in this case means:
1. A 2.4 series kernel with good support for Xilinx peripheral devices 
(existing Xilinx ML300 support is fine).
2. Good stability

By default I'll use the Montavista linuxppc_2.4 tree unless there is a 
better choice out there.

Thanks!

Keith
