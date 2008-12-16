Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2D46DDDF15
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 06:01:02 +1100 (EST)
Message-ID: <4947FABD.8090209@freescale.com>
Date: Tue, 16 Dec 2008 13:00:13 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] powerpc/83xx: Fix few build errors
	with	CONFIG_QUICC_ENGINE=n
References: <20081205165504.GA30966@oksana.dev.rtsoft.ru>	<6C14C18C-D709-4E69-8B47-C8A13380D713@kernel.crashing.org>
	<20081216184451.GA6959@oksana.dev.rtsoft.ru>
In-Reply-To: <20081216184451.GA6959@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
>   GCC can still issue the of_find_node_by_name() call. (I wonder if
>   there is any way to tell gcc that particular function doesn't
>   produce any side-effects so that gcc can optimize it away too).

__attribute__((pure))

-Scott
