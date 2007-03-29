Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 406D2DDE09
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 08:07:41 +1000 (EST)
Subject: Re: publishing OF platform devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200703292357.05205.arnd@arndb.de>
References: <4b73d43f0703291420v620b871fp97cb34941b1e7a85@mail.gmail.com>
	<460C2F0F.3050808@246tNt.com>  <200703292357.05205.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 08:07:32 +1000
Message-Id: <1175206052.5624.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The ppc_md->init() function is currently only present on 32 bit,
> if we decide that this is the way to go, we should make it common
> to both 32 and 64 bit platforms.

I still think we should do something like platform_xxx_initcall(); with
xxx being {core,subsys,device,...} ... I'll look into it. ppc_md.init()
is a bit gross.

Ben.
