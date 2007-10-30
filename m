Return-Path: <rwoodworth@securics.com>
Received: from securics.com (unknown [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id 8C7D0DE203
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Oct 2007 02:55:49 +1100 (EST)
Received: from [192.168.1.125] (c-75-70-32-46.hsd1.co.comcast.net
	[75.70.32.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by securics.com (Postfix) with ESMTP id 5D7C6B8C0B9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Oct 2007 09:28:59 -0600 (MDT)
Subject: videobuf
From: Robert Woodworth <rwoodworth@securics.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 30 Oct 2007 09:28:58 -0600
Message-Id: <1193758138.4606.7.camel@PisteOff>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm  working on building a v4l2 driver for an FPGA module on a Xilinx
Virtex4 PPC.

Question:
Why does the v4l2 videobuf *depend* on PCI?




Rob.

 
