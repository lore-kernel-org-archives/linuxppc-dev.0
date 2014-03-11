Return-Path: <saikia.partha@gmail.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C24D82C0079
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 23:55:23 +1100 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <saikia.partha@gmail.com>) id 1WNLuT-0005BB-8g
 for linuxppc-dev@ozlabs.org; Tue, 11 Mar 2014 05:35:53 -0700
Date: Tue, 11 Mar 2014 05:35:53 -0700 (PDT)
From: perth1415 <saikia.partha@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1394541351657-80711.post@n7.nabble.com>
In-Reply-To: <r2u389deec71004291743ra5fe0d49yaf317b5c5aaea6b7@mail.gmail.com>
References: <r2u389deec71004291743ra5fe0d49yaf317b5c5aaea6b7@mail.gmail.com>
Subject: Re: how do I increase default kernel stack size for my MPC8548 board?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have the exact same query. We have a board with MPC8378, which is a 32-bit
processor running 2.6-25 kernel. I increased THREAD_SHIFT to 14. Now the
board hangs just after the "Uncompressing Kernel Image ... OK" message from
U-boot.
Is there any other change required for 16k stack apart from THREAD_SHIFT?

Thanks,
Partha



--
View this message in context: http://linuxppc.10917.n7.nabble.com/how-do-I-increase-default-kernel-stack-size-for-my-MPC8548-board-tp52842p80711.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
