Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 777F0679E0
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 20:40:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/6]: powerpc/cell spidernet ethernet patches
Date: Sat, 30 Sep 2006 12:40:00 +0200
References: <20060929230552.GG6433@austin.ibm.com>
In-Reply-To: <20060929230552.GG6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609301240.03464.arnd@arndb.de>
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Saturday 30 September 2006 01:05 schrieb Linas Vepstas:
> Although these patches have not been baking in
> any -mm tree, they have been tested and are
> generally available as a part of the Cell SDK 2.0
> overseen by Arnd Bergmann. (Arnd, if you want
> to lend a voice of authority here, or to correct
> me, please do so...)
>
> The following sequence of six patches implement a
> series of changes to the transmit side of the
> spidernet ethernet device driver, significantly
> improving performance for large packets.
>
> This series of patches is almost identical to
> those previously mailed on 18-20 August, with one
> critical change: NAPI polling is used instead of
> homegrown polling.
>
> Although these patches improve things, I am not
> satisfied with how this driver behaves, and so
> plan to do additional work next week.
>

I'm not sure if I have missed a patch in here, but I
don't see anything reintroducing the 'netif_stop_queue'
that is missing from the transmit path.

Do you have a extra patch for that?

	Arnd <><
