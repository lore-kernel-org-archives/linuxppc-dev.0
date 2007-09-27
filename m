Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id B5A8DDDE03
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 21:41:22 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/5] PowerPC: Move of_device allocation into of_device.[ch]
Date: Thu, 27 Sep 2007 13:27:41 +0200
References: <200709261143.24735.fenkes@de.ibm.com>
	<200709261144.14282.fenkes@de.ibm.com>
In-Reply-To: <200709261144.14282.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709271327.42781.arnd@arndb.de>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 September 2007, Joachim Fenkes wrote:
> Extract generic of_device allocation code from of_platform_device_create()
> and move it into of_device.[ch], called of_device_alloc(). Also, there's now
> of_device_free() which puts the device node.
> 
> This way, bus drivers that build on of_platform (like ibmebus will) can
> build upon this code instead of reinventing the wheel.
> 
> Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
