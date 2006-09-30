Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id BDC07679A6
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 20:32:18 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/6]: powerpc/cell spidernet burst alignment patch.
Date: Sat, 30 Sep 2006 12:29:00 +0200
References: <20060929230552.GG6433@austin.ibm.com>
	<20060929231511.GI6433@austin.ibm.com>
In-Reply-To: <20060929231511.GI6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609301229.00862.arnd@arndb.de>
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Saturday 30 September 2006 01:15 schrieb Linas Vepstas:
> This patch increases the Burst Address alignment from 64 to 1024 in the
> Spidernet driver. This improves transmit performance for large packets.
>
> From: James K Lewis <jklewis@us.ibm.com>
> Signed-off-by: James K Lewis <jklewis@us.ibm.com>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
