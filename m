Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 95FE8DDFA3
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:48:18 +1100 (EST)
In-Reply-To: <20070124210709.GF10527@ld0162-tx32.am.freescale.net>
References: <20070124210709.GF10527@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4EF444AA-B7C0-460D-BA0A-EEDC9E2E4812@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/18] Make ft_node_add() accept and return NULL.
Date: Wed, 24 Jan 2007 22:48:04 +0100
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

> Currently, if ft_node_add() is passed NULL it will allocate an  
> entry for
> it and return a non-NULL phandle.  This patch makes it simply pass the
> NULL through.

Hrm, is this a good thing?  Shouldn't you just BUG_ON()
instead?


Segher
