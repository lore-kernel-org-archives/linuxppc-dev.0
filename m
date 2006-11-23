Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id D9D9367BBE
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2006 00:10:09 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Missed renames of CONFIG_PS3 to CONFIG_PPC_PS3
Date: Thu, 23 Nov 2006 14:09:55 +0100
References: <Pine.LNX.4.62.0611231346070.15461@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0611231346070.15461@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611231409.55709.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 23 November 2006 13:50, Geert Uytterhoeven wrote:
> 
> When renaming CONFIG_PS3 to CONFIG_PPC_PS3, a few occurrences have been
> missed.

Sorry about this, my fault. I checked the Kconfig and .c files, but
missed the Makefiles.

> I also fixed up the alignment in arch/powerpc/platforms/Makefile.
> 
> Signed-Off-By: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
