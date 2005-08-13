Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id 20C4567E9B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Aug 2005 11:11:15 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i13so726000wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 18:11:14 -0700 (PDT)
Message-ID: <c3d0340b0508121811e7b6fc2@mail.gmail.com>
Date: Fri, 12 Aug 2005 18:11:14 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: writel(), readl() in <asm-ppc/io.h>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

In <asm-ppc/io.h>, writew(), readw(), writel(), and readl() are
defined to little endian access for all platforms unless either
CONFIG_APUS or CONFIG_8260_PCI9 is defined.

Why? Aren't they correct in big endian systems, are they? Maybe I miss
something here.

Regards,
-Shawn.
