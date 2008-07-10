Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87D44DDDF9
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 12:41:35 +1000 (EST)
Received: from [192.168.0.123] (unknown [123.118.16.158])
	by mx.linux.net.cn (Postfix) with ESMTP id AF7C93EC09
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 10:48:41 +0800 (CST)
Message-ID: <487576E0.10501@linux.net.cn>
Date: Thu, 10 Jul 2008 10:41:36 +0800
From: Wang Jian <lark@linux.net.cn>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/2] Fix register misuse in drivers/net/phy/marvel.c
References: <4875707D.8060808@linux.net.cn>
In-Reply-To: <4875707D.8060808@linux.net.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It may not be appropriate to post here instead of netdev, but I am using 
powerpc dev board and I think there will be someone here who has board 
to test.

Wang Jian 写道:
> These 2 patches fixed misuse of register for 88e1111.
> 
> Notice: These two patches didn't fix some auto selection problem yet. I
> will discuss the problem in seperate email.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 
