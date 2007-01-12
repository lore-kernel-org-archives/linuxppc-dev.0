Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC7B4DDE01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 11:58:02 +1100 (EST)
Subject: Re: [PATCH 2/2] drivers/ata: export some static functions in
	libata-core.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070111171706.GG6177@austin.ibm.com>
References: <200701110853.l0B8rtGK009404@toshiba.co.jp>
	<200701111008.34866.arnd@arndb.de>
	<200701110928.l0B9SUri015056@toshiba.co.jp>
	<20070111171706.GG6177@austin.ibm.com>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 11:55:44 +1100
Message-Id: <1168563344.22458.430.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Why is it that other drivers did not need this functions? Did they
> copy them?  Or maybe they don't need them?

Most drivers can use the common functions as is. The problem starts when
you need special mecanisms to access the taskfile registers.

Ben.
