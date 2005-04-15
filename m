Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.198])
	by ozlabs.org (Postfix) with ESMTP id 82A9F67B75
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Apr 2005 07:36:52 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id 40so387043rnz
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Apr 2005 14:36:51 -0700 (PDT)
Message-ID: <c3d0340b05041514362746169a@mail.gmail.com>
Date: Fri, 15 Apr 2005 14:36:51 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Interrupt prioritization on linux for ppc440
Reply-To: Shawn Jin <shawnxjin@gmail.com>
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

The home-made interrupt controller PIC supports interrupt priorities
and critical/non-critical interrupts. I found that the current kernel
doesn't support interrupt priorities. Is this observation true? Is
there any existing patch to support that? Can RTAI or RTLinux
prioritize interrupts?

I noticed that the implementation of ppc4xx_pic.c disables all
critical interrupts during initialization. To support critical
interrupts, is it so simple that we change the handler of critical
exception from CriticalInput to do_IRQ in head_44x.S?

Would you please share some of your inputs with me while I'm googling
this issue?

Thanks,
-Shawn.
