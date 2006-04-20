Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 54F8D67A63
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 06:59:45 +1000 (EST)
Subject: Re: [patch] powerpc: move PAGE_SIZE outside #ifdef __KERNEL__
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4447C3BA.6050709@am.sony.com>
References: <4447C3BA.6050709@am.sony.com>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 06:59:33 +1000
Message-Id: <1145566774.17087.72.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-04-20 at 10:24 -0700, Geoff Levand wrote:
> The procps package needs PAGE_SIZE, defined in asm-powerpc/page.h,
> but it is defined inside "#ifdef __KERNEL__".
> 
> This moves the PAGE_SIZE definition outside of "#ifdef __KERNEL__".

NAK. The procps package is bogus if it needs PAGE_SIZE since it can
change based on a config option...

Ben.
