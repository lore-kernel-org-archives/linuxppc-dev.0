Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 31BC5DDE07
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 21:45:24 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/5] ibmebus: Move to of_device and of_platform_driver,
	match eHCA and eHEA drivers
Date: Thu, 27 Sep 2007 13:31:01 +0200
References: <200709261143.24735.fenkes@de.ibm.com>
	<200709261145.51926.fenkes@de.ibm.com>
In-Reply-To: <200709261145.51926.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709271331.02715.arnd@arndb.de>
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
> Replace struct ibmebus_dev and struct ibmebus_driver with struct of_device
> and struct of_platform_driver, respectively. Match the external ibmebus
> interface and drivers using it.
> 
> Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
