Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id 8DCA667A33
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 10:39:24 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so497238wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 17:39:23 -0700 (PDT)
Message-ID: <c3d0340b05042117321cd86686@mail.gmail.com>
Date: Thu, 21 Apr 2005 17:32:43 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: TODC on ppc440
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

Our SoC using ppc440 core will run on an emulator first. It doesn't
have an external RTC. Hence time_init, set_rtc_time, get_rtc_time of
ppc_md are all set to NULL. No TODC_ALLOC() is defined.

I'm wondering if todc is vital to make OS run correctly. Is there any
other choice?

I grepped ppc_md.time_init in the kernel source. It seems that linux
can run without ppc_md.time_init.

Any ideas?

-Shawn.
