Return-Path: <gene.smith@siemens.com>
Received: from APH0Z28A.d228.us002.siemens.net.local (gtwy.sea.siemens.com
	[208.5.44.21]) by ozlabs.org (Postfix) with ESMTP id 8D55E2BF0F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Oct 2004 07:21:08 +1000 (EST)
Message-ID: <4179628F.1020703@siemens.com>
Date: Fri, 22 Oct 2004 15:42:07 -0400
From: "Smith, Gene" <gene.smith@siemens.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Basic 405gp question
Reply-To: gene.smith@siemens.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a custom 405GPr board containing 64M ram and 4M flash with no PCI 
connector, just ethernet and ttyS0/1 to outside world. I am able to load 
and run simple ppc code to ram using a Macraigor JTAG debugger via 
insight/gdb using gnu tools provided by them.

What would it take to get linux running on this board? Any pointers or 
suggestions would be appreciated.

Thanks,
-gene
