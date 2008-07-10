Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 28F48DDF64
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 12:35:21 +1000 (EST)
Received: from [192.168.0.123] (unknown [123.118.16.158])
	by mx.linux.net.cn (Postfix) with ESMTP id ACD373EC09
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 10:20:39 +0800 (CST)
Message-ID: <4875707D.8060808@linux.net.cn>
Date: Thu, 10 Jul 2008 10:14:21 +0800
From: Wang Jian <lark@linux.net.cn>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] Fix register misuse in drivers/net/phy/marvel.c
Content-Type: text/plain; charset=GB2312
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These 2 patches fixed misuse of register for 88e1111.

Notice: These two patches didn't fix some auto selection problem yet. I
will discuss the problem in seperate email.
