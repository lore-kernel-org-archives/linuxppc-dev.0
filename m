Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id AAAD5DE209
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 06:51:32 +1100 (EST)
Message-ID: <45BFA1B8.7050203@freescale.com>
Date: Tue, 30 Jan 2007 13:51:20 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/18] bootwrapper: Make ft_get_phandle() accept and return
	NULL.
References: <20070129201201.GF13485@ld0162-tx32.am.freescale.net>
	<C6B564EE-CF80-45E7-868B-28A43EDED755@kernel.crashing.org>
In-Reply-To: <C6B564EE-CF80-45E7-868B-28A43EDED755@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> Currently, if ft_get_phandle() is passed NULL it will allocate an  entry
>> for it and return a non-NULL phandle.  This patch makes it simply pass
>> the NULL through.
> 
> 
> Seems like an obvious bug fix to me -- I assume you
> audited all callers?  Although I can't imagine
> anything relying on such weird behaviour ;-)

The only caller that existed before my patches was ft_find_device(), 
which was only used to implement dt_ops.finddevice().

-Scott
