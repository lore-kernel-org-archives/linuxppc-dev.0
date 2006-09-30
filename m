Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id CB9B567C43
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 20:35:28 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/6]: powerpc/cell spidernet stop error printing patch.
Date: Sat, 30 Sep 2006 12:32:04 +0200
References: <20060929230552.GG6433@austin.ibm.com>
	<20060929231922.GK6433@austin.ibm.com>
In-Reply-To: <20060929231922.GK6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609301232.04585.arnd@arndb.de>
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

Am Saturday 30 September 2006 01:19 schrieb Linas Vepstas:
> Turn off mis-interpretation of the queue-empty interrupt
> status bit as an error. This bit is set as a part of
> the previous low-watermark patch.
>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Signed-off-by: James K Lewis <jklewis@us.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
