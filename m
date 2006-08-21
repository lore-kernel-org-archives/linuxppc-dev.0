Return-Path: <osstklei@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D55867B97
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 22:16:53 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7LCGmT4059054
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 12:16:48 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7LCKlSj130496
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 14:20:47 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7LCGmje013349
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 14:16:48 +0200
Message-ID: <44E9A42F.3000900@de.ibm.com>
Date: Mon, 21 Aug 2006 14:16:47 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [2.6.19 PATCH 7/7] ehea: Makefile & Kconfig
References: <200608181337.44153.ossthema@de.ibm.com>
	<20060818141847.GE5201@martell.zuzino.mipt.ru>
In-Reply-To: <20060818141847.GE5201@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexey Dobriyan wrote:
 > On Fri, Aug 18, 2006 at 01:37:44PM +0200, Jan-Bernd Themann wrote:
 >> --- linux-2.6.18-rc4/drivers/net/Kconfig
 >> +++ patched_kernel/drivers/net/Kconfig
 >> @@ -2277,6 +2277,12 @@ config CHELSIO_T1
 >>            To compile this driver as a module, choose M here: the module
 >>            will be called cxgb.
 >>
 >> +config EHEA
 >> +        tristate "eHEA Ethernet support"
 >> +        depends on IBMEBUS
 >> +        ---help---
 >> +          This driver supports the IBM pSeries ethernet adapter
 >                                                                 .
 >
 > People usually add the following boilerplate:
 >
 >       To compile this driver as a module, choose M here: the module
 >       will be called $FOO.

Agreed.
