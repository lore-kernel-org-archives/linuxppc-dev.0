Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler4.mail.xerox.com (wvmler4.mail.xerox.com [13.8.138.219])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler4.mail.xerox.com",
	Issuer "wvmler4.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C9DED67B83
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 21:17:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/6] ehea: header files
Date: Tue, 15 Aug 2006 11:53:05 +0100
Message-ID: <35786B99AB3FDC45A821572461791973AC87D3@gbrwgceumf01.eu.xerox.net>
In-Reply-To: <44E19765.7030301@de.ibm.com>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Jan-Bernd Themann" <ossthema@de.ibm.com>, <michael@ellerman.id.au>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > You mean the eHEA has its own concept of page size? Separate from
the
> > page size used by the MMU?
> >=20
>=20
> yes, the eHEA currently supports only 4K pages for queues

In that case, I suggest use the kernel's page size, but add a
compile-time
check, and quit with an error message if driver does not support it.

Regards,
Clive
