Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 31F5767B1A
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 20:31:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/6]: powerpc/cell spidernet low watermark patch.
Date: Sat, 30 Sep 2006 12:30:59 +0200
References: <20060929230552.GG6433@austin.ibm.com>
	<20060929231730.GJ6433@austin.ibm.com>
In-Reply-To: <20060929231730.GJ6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609301230.59776.arnd@arndb.de>
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

Am Saturday 30 September 2006 01:17 schrieb Linas Vepstas:
> Implement basic low-watermark support for the transmit queue.
> Hardware low-watermarks allow a properly configured kernel
> to continously stream data to a device and not have to handle
> any interrupts at all in doing so. Correct zero-interrupt
> operation can be actually observed for this driver, when the
> socket buffer is made large enough.

Acked-by: Arnd Bergmann <arnd@arndb.de>
