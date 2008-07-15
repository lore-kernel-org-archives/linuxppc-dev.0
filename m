Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id BF33CDE23B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 04:24:52 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 82xx performance
Date: Tue, 15 Jul 2008 13:25:16 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04AE6877@ismail.innsys.innovsys.com>
In-Reply-To: <200807142244.07450.arnd@arndb.de>
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807142244.07450.arnd@arndb.de>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Arnd Bergmann" <arnd@arndb.de>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> * Maybe there is a kernel version that supports your hardware in both
> arch/ppc/ and arch/powerpc. In that case, you could see if=20
> the platform
> change had an impact.

Using arch/ppc I got a 2.6.25 kernel to boot, and the kernel compile
test I did is almost identical (within 1%) of what the arch/powerpc
2.6.25 did, so it seems to be a difference between 2.6.18 and 2.6.25
(I'll see if I can find an exact version, as I think my ppc port can be
compiled for all versions from 2.6.18 to 25)

And running oprofile didn't help much, as it seems not to have been able
to figure out what in the kernel got called. (the Freescale 82xx dcoes
not have hw performance registers)
