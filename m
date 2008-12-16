Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 766C9DDDED
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 06:14:21 +1100 (EST)
Date: Tue, 16 Dec 2008 22:14:19 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/83xx: Fix few build errors with
	CONFIG_QUICC_ENGINE=n
Message-ID: <20081216191419.GA31928@oksana.dev.rtsoft.ru>
References: <20081205165504.GA30966@oksana.dev.rtsoft.ru>
	<6C14C18C-D709-4E69-8B47-C8A13380D713@kernel.crashing.org>
	<20081216184451.GA6959@oksana.dev.rtsoft.ru>
	<4947FABD.8090209@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <4947FABD.8090209@freescale.com>
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

On Tue, Dec 16, 2008 at 01:00:13PM -0600, Scott Wood wrote:
> Anton Vorontsov wrote:
>>   GCC can still issue the of_find_node_by_name() call. (I wonder if
>>   there is any way to tell gcc that particular function doesn't
>>   produce any side-effects so that gcc can optimize it away too).
>
> __attribute__((pure))

Ah, thanks!

But I forgot that of_find_node_by_name() and friends aren't
actually "pure", they're getting the node. :-(

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
