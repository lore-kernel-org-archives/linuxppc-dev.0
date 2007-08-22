Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id EACDCDDF0B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 08:54:13 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Patches added to powerpc.git for-2.6.24 branch
Date: Thu, 23 Aug 2007 00:39:05 +0200
References: <18124.1591.112487.322248@cargo.ozlabs.ibm.com>
	<653AD812-D186-4876-BF52-F3A5D887B82E@kernel.crashing.org>
	<694575D6-C4BC-4FFB-91C1-B692181CEF6F@kernel.crashing.org>
In-Reply-To: <694575D6-C4BC-4FFB-91C1-B692181CEF6F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708230039.07061.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 22 August 2007, Kumar Gala wrote:
> I think we can all agree that the amiga*.h, zorro.h and traps.h can =A0
> be ignored since they have to do with amiga/apus support.

arch/powerpc/kernel/setup_32.c unconditionally #includes <asm/amigappc.h>,
the rest looks unused indeed.

	Arnd <><
