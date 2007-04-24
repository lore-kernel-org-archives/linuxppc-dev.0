Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id DB34DDDDFB
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 03:27:13 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [PATCH] powerpc: uninline of_iomap function
Date: Tue, 24 Apr 2007 19:27:02 +0200
References: <20070423193538.576702568@arndb.de>
	<1177378533.14873.48.camel@localhost.localdomain>
	<20070424173202.15e5ce42@localhost>
In-Reply-To: <20070424173202.15e5ce42@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200704241927.03141.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 24 April 2007, Christian Krafft wrote:
>   From: Christian Krafft <krafft@de.ibm.com>
> There is no big reason to have that function inlined.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
