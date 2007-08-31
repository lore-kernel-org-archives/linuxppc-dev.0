Return-Path: <FENKES@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3172FDDF86
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Sep 2007 00:34:58 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7VEYsW5289032
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 14:34:54 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7VEYs0s2199652
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 16:34:54 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7VEYrcr023752
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 16:34:54 +0200
In-Reply-To: <200708302022.24167.arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
MIME-Version: 1.0
Subject: Re: [PATCH 2.6.23] ibmebus: Prevent bus_id collisions
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFBB1BA4B6.29175A76-ONC1257348.004DBCB3-C1257348.0050161C@de.ibm.com>
Date: Fri, 31 Aug 2007 16:34:51 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: Thomas Q Klein <tklein@de.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Christoph Raisch <raisch@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Arnd,

> The whole logic of dynamically adding and removing device is rather 
bogus,
> and it prevents autoloading of device drivers. of_platform_make_bus_id
> is the function that is responsible for creating unique names over 
there.

The plaintiff makes a valid point. How about a staging approach: We put 
the patch as it is now into 2.6.23 so the problem is fixed, and I'll post 
a "nice" version with autoloading support and a generic of_make_bus_id 
function for 2.6.24. Agree?

Regards,
  Joachim
