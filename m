Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id E9801DDED5
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 07:14:45 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] hide kernel only code in asm-powerpc/elf.h
Date: Mon, 28 Jan 2008 21:14:30 +0100
References: <20080125180841.GA30091@aepfle.de>
In-Reply-To: <20080125180841.GA30091@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801282114.31421.arnd@arndb.de>
Cc: Olaf Hering <olaf@aepfle.de>, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 25 January 2008, Olaf Hering wrote:
> stuff inside CONFIG_* should not be exported via make headers-install
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I think at some point I even had a script to automatically check
for this kind of bug. Using any #ifdef CONFIG_* in an exported
header is guaranteed to be a bug, because we don't export
config.h.

	Arnd <><
