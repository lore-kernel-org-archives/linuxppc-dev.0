Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 35B2DDDFBA
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Sep 2007 03:10:17 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Joachim Fenkes <FENKES@de.ibm.com>
Subject: Re: [PATCH 2.6.23] ibmebus: Prevent bus_id collisions
Date: Fri, 31 Aug 2007 19:08:04 +0200
References: <OFBB1BA4B6.29175A76-ONC1257348.004DBCB3-C1257348.0050161C@de.ibm.com>
In-Reply-To: <OFBB1BA4B6.29175A76-ONC1257348.004DBCB3-C1257348.0050161C@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708311908.05255.arnd@arndb.de>
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

On Friday 31 August 2007, Joachim Fenkes wrote:
> > The whole logic of dynamically adding and removing device is rather 
> bogus,
> > and it prevents autoloading of device drivers. of_platform_make_bus_id
> > is the function that is responsible for creating unique names over 
> there.
> 
> The plaintiff makes a valid point. How about a staging approach: We put 
> the patch as it is now into 2.6.23 so the problem is fixed, and I'll post 
> a "nice" version with autoloading support and a generic of_make_bus_id 
> function for 2.6.24. Agree?

Ok, sounds fair. Can you make sure that the resulting bus_id is the same
for the final version then?

	Arnd <><
