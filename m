Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 01A72DEF3D
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 05:51:37 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 82xx performance
Date: Tue, 15 Jul 2008 21:50:35 +0200
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807142244.07450.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04AE6877@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04AE6877@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807152150.35811.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 15 July 2008, Rune Torgersen wrote:
> Using arch/ppc I got a 2.6.25 kernel to boot, and the kernel compile
> test I did is almost identical (within 1%) of what the arch/powerpc
> 2.6.25 did, so it seems to be a difference between 2.6.18 and 2.6.25
> (I'll see if I can find an exact version, as I think my ppc port can be
> compiled for all versions from 2.6.18 to 25)

You probably already know git-bisect, but if you don't, you should
definitely give it a try. It's the best tool to find which patch
exactly broke your performance.

	Arnd <><
