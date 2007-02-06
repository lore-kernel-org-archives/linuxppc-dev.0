Return-Path: <watashin@mvision.co.jp>
Received: from mail.asahi-net.or.jp (mail2.asahi-net.or.jp [202.224.39.198])
	by ozlabs.org (Postfix) with ESMTP id 6958EDDE44
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Feb 2007 20:04:03 +1100 (EST)
Received: from wata (c200018.ppp.asahi-net.or.jp [210.155.200.18])
	by mail.asahi-net.or.jp (Postfix) with SMTP id 47D36290AC
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Feb 2007 17:44:32 +0900 (JST)
Message-ID: <003b01c749cb$03998550$1601a8c0@wata>
From: "Shinji Watanabe" <watashin@mvision.co.jp>
To: <linuxppc-embedded@ozlabs.org>
Subject: How to access MPC8555 DMA register ?
Date: Tue, 6 Feb 2007 17:44:28 +0900
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-2022-jp";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, all.

I used MPC8555CDS.

How to access DMA registers of MPC8555 ?

I can't read/write these registers on LINUX.

I called request_mem_region( 0xE0000000, LENGTH, ... ) in my device driver.

When I set LENGTH 0x21100, this function call succeded.

But When I set LENGTH 0x21200, this function call failed.

"e0021100-e002117f : fsl-dma0" is part of /proc/iomem log.

I guess my driver can't access fsl-dma0 area.

But fsl-dma0 area encompassed DMA registers I want to access.

I must find remove simbols like fsl-dma0.
Or I must find how to use modules encompass fsl-dma0.

Counld you give me some help/hint/tips ?

regards,

Shinji
