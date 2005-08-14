Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.202])
	by ozlabs.org (Postfix) with ESMTP id D2A8167EB8
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Aug 2005 13:56:52 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i13so850265wra
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Aug 2005 20:56:51 -0700 (PDT)
Message-ID: <c3d0340b0508132056651e8c97@mail.gmail.com>
Date: Sat, 13 Aug 2005 20:56:50 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20050812203335.K30033@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c3d0340b0508121811e7b6fc2@mail.gmail.com>
	<20050812203335.K30033@cox.net>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: writel(), readl() in <asm-ppc/io.h>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> read*()/write*() are accessors for PCI and PCI only.  PCI is little

If read*()/write*() are designed for PCI access only as you claimed,
that explains why they call in/out_leXX() funcitons.

The problem is that read*()/write*() are misused in some places, e.g.,
serial drivers such as serial8250. The serial_in() and serial_out()
call read*() and write*() respectively. So what's your recommendation
in such a case?

Regards,
-Shawn.
