Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 55ADF67D50
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 21:30:03 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Fix __raw* accessors
Date: Tue, 21 Nov 2006 11:29:59 +0100
References: <1164072929.8073.45.camel@localhost.localdomain>
In-Reply-To: <1164072929.8073.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611211129.59685.arnd@arndb.de>
Cc: Jens Osterkamp <jens.osterkamp@de.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 21 November 2006 02:35, Benjamin Herrenschmidt wrote:
> The new IO accessor code allows to stick a token in the top bit of MMIO
> addresses which gets masked out during actual accesses. However, the
> __raw_* accessors forgot to mask it out. This fixes it.

Jens, you debugged the problem originally. Does this patch fix it entirely,
or is there something else missing?

	Arnd <><
