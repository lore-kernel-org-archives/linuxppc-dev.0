Return-Path: <leo_guo@jisung.cn>
Received: from mxvip3.hichina.com (unknown [218.30.103.131])
	by ozlabs.org (Postfix) with ESMTP id 8430A67A67
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Mar 2005 12:29:41 +1100 (EST)
Received: from 218.83.157.44 (HELO IBM-91A6822F063) (envelope-from
	leo_guo@jisung.cn)
	by mxvip3.hichina.com (quarkmail-1.2.1) with ESMTP id S334290AbVCHBW6
	for linuxppc-embedded@ozlabs.org; Tue, 8 Mar 2005 09:22:58 +0800
Date: Tue, 8 Mar 2005 09:22:58 +0800
From: "leo" <leo_guo@jisung.cn>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Message-Id: <20050308012941.8430A67A67@ozlabs.org>
Subject: MPC82XX and SATA hardisk performance.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,
	I use the PCI bus and PCI-SATA bridge SII3112 to expand two SATA port, my MPC8250 work frequency is CORE/CPM/BUS 200/133/66M, filesystem use ext2 under linux, i write a program to test the maxmium written speed, the result is about 60MBps/S, maybe it's too slow?  Anyone who has experience can give me some advice? How can I increase the written speed?

Best Regards!

Leo.
