Return-Path: <patrick.huesmann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id 172D4679E2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 20:54:31 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so1757324wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 03:54:30 -0700 (PDT)
Message-ID: <93579fec0505100354623af3fc@mail.gmail.com>
Date: Tue, 10 May 2005 12:54:30 +0200
From: Patrick Huesmann <patrick.huesmann@gmail.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <427FB3A5.5080702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <427FB3A5.5080702@gmail.com>
Subject: Re: How to increase kernel stack size?
Reply-To: Patrick Huesmann <patrick.huesmann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Just FYI:

The symbol INIT_TASK_SIZE defines the length of a union (task_union)
which holds the kernel stack. But when I define this value to be
larger than 8192, the kernel wouldn't boot.
So this value is probably hard-coded somewhere else.

BTW, I'm using 2.4.26

Does someone know how to increase the kernel stack size for PPC archs?
I really need more stack for my external interrupt b/c sometimes the
peripheral generates fast bursts on the external interrupt line, which
lead to kernel stack overflow.
(SA_INTERRUPT doesn't help because this is a realtime interrupt).

Any ideas?

TIA,
Patrick
