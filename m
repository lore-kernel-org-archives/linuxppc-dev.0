Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1331FDDF25
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 03:36:41 +1100 (EST)
Date: Thu, 18 Dec 2008 19:36:40 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/4] Few patches for galak/powerpc.git next
Message-ID: <20081218163640.GA21049@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar, Timur,

Much thanks for the reviews and comments, here is an updated patch set.

Changes:
- BCSR GPIO bindings were split into a separate patch.
- simple_gpiochip_init() return value changed to void (the function
  prints errors by itself, and we don't check its return value anyway).

p.s.
>> +- reg : Should contain the address and the lenght of the GPIO bank
>> +  register;
>
> spelling - length
> semicolon at add of register can be dropped.

Umm.. the semicolon denotes the end of the list item.
Anyhow, I see that periods are used more widely, so I replaced
semicolons with periods.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
