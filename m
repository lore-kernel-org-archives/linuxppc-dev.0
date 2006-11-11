Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 2E9B767EF9
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 13:04:07 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/16] cell: set ARCH_SPARSEMEM_DEFAULT in Kconfig
Date: Sat, 11 Nov 2006 03:04:02 +0100
References: <4554DA6F.6060400@am.sony.com>
In-Reply-To: <4554DA6F.6060400@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611110304.02614.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 10 November 2006 21:00, Geoff Levand wrote:
> The current cell processor support needs sparsemem, so set it as
> the default memory model.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
Acked-by: Arnd Bergmann <arnd@arndb.de>
