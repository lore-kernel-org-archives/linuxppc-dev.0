Return-Path: <pengxihan@gmail.com>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id 1D2B5B7D53
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 10:43:01 +1000 (EST)
Received: by iwn11 with SMTP id 11so12424846iwn.11
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 17:43:00 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 30 Apr 2010 08:43:00 +0800
Message-ID: <r2u389deec71004291743ra5fe0d49yaf317b5c5aaea6b7@mail.gmail.com>
Subject: how do I increase default kernel stack size for my MPC8548 board?
From: hank peng <pengxihan@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In kernel source, default kernel stack size for PPC32 is as follows:
#if defined(CONFIG_PPC64)
#define THREAD_SHIFT		14
#elif defined(CONFIG_PPC_256K_PAGES)
#define THREAD_SHIFT		15
#else
#define THREAD_SHIFT		13
#endif

#define THREAD_SIZE		(1 << THREAD_SHIFT)

So, default value is 8K, but now I want to increase it to 16K, is it
OK just to change THREAD_SHIFT to 14? or is there some patch needed?

-- 
The simplest is not all best but the best is surely the simplest!
