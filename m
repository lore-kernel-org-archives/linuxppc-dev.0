Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 3E4BFDDEDA
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 07:24:13 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 32-bit kernel on PPC64 supported?
Date: Fri, 18 Jul 2008 23:24:08 +0200
References: <200807182043.08991.marvin24@gmx.de>
In-Reply-To: <200807182043.08991.marvin24@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807182324.09219.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 18 July 2008, Marvin wrote:
> in which POWER4 is always undefined, e.g. in 
> include/asm-powerpc/mmu_context.h. Maybe this is a leftover from times, where 
> 64-bit kernels where not supported on Powermacs. Is this 32-bit support still 
> necessary?

There is currently no 64-bit machine that is supported by current kernels,
and I don't think there is any reason to add this again.

I'm not sure what the point of your plan to replace CONFIG_POWER4 is, but
it sounds like this case is slightly different, as you remove a potential
feature, so I guess it should be a separate patch.

	Arnd <><
