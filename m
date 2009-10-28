Return-Path: <pengxihan@gmail.com>
Received: from mail-pw0-f50.google.com (mail-pw0-f50.google.com
	[209.85.160.50]) by ozlabs.org (Postfix) with ESMTP id 26F40B7B93
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Oct 2009 11:45:17 +1100 (EST)
Received: by pwi4 with SMTP id 4so487736pwi.9
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 17:45:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20091027182830.8e99be49.kim.phillips@freescale.com>
References: <389deec70910262043v34bcd7edy6f00241d126b1816@mail.gmail.com>
	<20091027182830.8e99be49.kim.phillips@freescale.com>
Date: Wed, 28 Oct 2009 08:45:17 +0800
Message-ID: <389deec70910271745l71b042e3l2e1d11edcc788dab@mail.gmail.com>
Subject: Re: Is there a patch for MPC8548 XOR?
From: hank peng <pengxihan@gmail.com>
To: Kim Phillips <kim.phillips@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/10/28 Kim Phillips <kim.phillips@freescale.com>:
> On Tue, 27 Oct 2009 11:43:34 +0800
> hank peng <pengxihan@gmail.com> wrote:
>
>> I want to use its' XOR engine to compute raid5 parity, but I can't
>> find this function in 2.6.30 downloaded from kernel.org, someone know
>> if there is a patch?
>
> try this:
>
> http://patchwork.ozlabs.org/patch/36067/
>
Thanks, but I have three questions:
1. Will the patch be added to kernel in the future?
2. If I have problem in using this patch, will you or other guys help
me to fix it?
3. Is this patch based on 2.6.30, because we are using this version of kernel.

> Kim
>



-- 
The simplest is not all best but the best is surely the simplest!
