Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 2FFD567F5C
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 13:13:50 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 8/16] powerpc: add ps3 platform hvcalls
Date: Sat, 11 Nov 2006 03:13:40 +0100
References: <4554DAD7.2090709@am.sony.com>
In-Reply-To: <4554DAD7.2090709@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611110313.40940.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 10 November 2006 21:02, Geoff Levand wrote:
> Adds the ps3pf hvcalls.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

This one reminds of the inline hcall abstraction layer I did
some time ago. The implementation in your patch is a lot
less elegant than both the pseries in its current incarnation
and the one that I did (IMHO). Any opinions on how we should
proceed here?

I can dig out my patch again in the version I did for the
ps3 hypervisor, if there is demand, or I could help moving
over so code that is more like the pseries one. Unfortunately
the calling conventions are very different from pseries 
(the hcall number is passed in r11, not in one of the argument
registers), so that would not be as nice as Anton's implementation.

	Arnd <><
