Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 9E599DE1CC
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 22:25:37 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 9/16] ps3: bind interrupt to cpu
Date: Sat, 27 Jan 2007 12:25:23 +0100
References: <45BAC218.8050606@am.sony.com>
In-Reply-To: <45BAC218.8050606@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701271225.23355.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 27 January 2007 04:08, Geoff Levand wrote:
> Change the PS3 irq allocation routines to take an argument indicating which
> cpu (processor thread) the interrupt should be serviced on.
> 
> The current system configuration favors device interrupts that are serviced
> on cpu0, so that is used as the default.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
