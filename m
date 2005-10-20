Return-Path: <ssshayagriva@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.195])
	by ozlabs.org (Postfix) with ESMTP id B299468632
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2005 06:02:36 +1000 (EST)
Received: by xproxy.gmail.com with SMTP id t8so259205wxc
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Oct 2005 13:02:35 -0700 (PDT)
Message-ID: <513a5e60510201256k64c0e4fan1557c28a0bdf920c@mail.gmail.com>
Date: Thu, 20 Oct 2005 14:56:21 -0500
From: Madhu Saravana Sibi Govindan <ssshayagriva@gmail.com>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: PowerPC/Linux device driver question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,

I'm trying to write a device driver in linux on a PowerPC processor.
The device has been allocated a range of addresses in the physical
address space of the processor (IBM 440GP) - from 0x100000000 -
0x13fffffff. (FYI, the 440GP is a 32 bit processor using 36 physical
addresses, the processor's MMU appends the extra 4 bits to get a
36-bit physical address).

I'm not sure how to request this range of physical memory from the
kernel. I thought I could use ioremap to map this range into the
virtual space, but ioremap takes only an unsigned long as an argument,
which is only 32 bits on 440GP. I don't think I can represent the range of =
my
device with 32 bits.

Could someone tell me how to solve the problem? I want this range of
physical addresses to be associated with my device driver and how do I
do that?

Thanks in advance,
G.Sibi
