Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 30487DDF9D
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 06:48:14 +1100 (EST)
In-Reply-To: <20070129201201.GF13485@ld0162-tx32.am.freescale.net>
References: <20070129201201.GF13485@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C6B564EE-CF80-45E7-868B-28A43EDED755@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/18] bootwrapper: Make ft_get_phandle() accept and
	return NULL.
Date: Tue, 30 Jan 2007 20:48:04 +0100
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Currently, if ft_get_phandle() is passed NULL it will allocate an  
> entry
> for it and return a non-NULL phandle.  This patch makes it simply pass
> the NULL through.

Seems like an obvious bug fix to me -- I assume you
audited all callers?  Although I can't imagine
anything relying on such weird behaviour ;-)

> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
