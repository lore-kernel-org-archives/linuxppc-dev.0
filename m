Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id 4C068DDDA6
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 09:44:45 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc/cell: add missing #include for oprofile
Date: Mon, 9 Feb 2009 23:44:30 +0100
References: <26307.1234134254@neuling.org>
In-Reply-To: <26307.1234134254@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200902092344.31327.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 09 February 2009, Michael Neuling wrote:
> arch/powerpc/oprofile/cell/spu_profiler.c is missing a asm/time.h
> include which is required for ppc_proc_freq.  This can cause compile
> failures for some config combinations.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
