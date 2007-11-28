Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 7648EDDDE7
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 19:19:56 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 kniht@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] powerpc: add hugepagesz boot-time parameter
Date: Wed, 28 Nov 2007 08:26:46 +0100
References: <474CF68E.1040709@us.ibm.com>
In-Reply-To: <474CF68E.1040709@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711280826.46820.arnd@arndb.de>
Cc: Linux Memory Management List <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 28 November 2007, Jon Tollefson wrote:
> This patch adds the hugepagesz boot-time parameter for ppc64 that lets=20
> you pick the size for your huge pages. =A0The choices available are 64K=20
> and 16M. =A0It defaults to 16M (previously the only choice) if nothing or=
=20
> an invalid choice is specified. =A0Tested 64K huge pages with the=20
> libhugetlbfs 1.2 release with its 'make func' and 'make stress' test=20
> invocations.

How hard would it be to add the 1MB page size that some CPUs support
as well? On systems with small physical memory like the PS3, that
sounds very useful to me.

	Arnd <><
