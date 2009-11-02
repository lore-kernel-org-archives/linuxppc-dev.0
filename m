Return-Path: <pengxihan@gmail.com>
Received: from mail-px0-f199.google.com (mail-px0-f199.google.com
	[209.85.216.199]) by ozlabs.org (Postfix) with ESMTP id 4BCB1B7C1E
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 02:40:03 +1100 (EST)
Received: by pxi37 with SMTP id 37so3203558pxi.15
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Nov 2009 07:40:02 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 2 Nov 2009 23:40:02 +0800
Message-ID: <389deec70911020740k13b56bc6kdad3bfaa39916f54@mail.gmail.com>
Subject: mpc8548 does not make use of DMA when doing memory copy?
From: hank peng <pengxihan@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kernel version is 2.6.30 and I have enabled fsl DMA engine during
configuring kernel. After system booted, I have seen only 38 DMA
interrupts, and no increase later when I am doing data transfer
through network.
So I wonder if mpc8548  had made use of DMA engine when doing memcpy,
or maybe if there are other things I haven't noticed?

-- 
The simplest is not all best but the best is surely the simplest!
