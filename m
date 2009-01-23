Return-Path: <Lee.Nipper@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B841DDFE0
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 03:51:10 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0NGp6eQ014312
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 09:51:07 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n0NGp6i2007602
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 10:51:06 -0600 (CST)
Subject: Re: powerpc ftrace functionality
From: Lee Nipper <lee.nipper@freescale.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
In-Reply-To: <1232398278.24188.318.camel@al08linux99>
References: <1232398278.24188.318.camel@al08linux99>
Content-Type: text/plain
Date: Fri, 23 Jan 2009 10:52:41 -0600
Message-Id: <1232729561.9573.47.camel@al08linux99>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-01-19 at 13:51 -0700, Lee Nipper wrote:
> Is ftrace functional with latest kernel on powerpc (32-bit) ?

> It appears broken unless I'm missing something.


FWIW, 2.6.29-rc2 powerpc ftrace works with one patch
from Steven Rostedt added in:

http://git.kernel.org/?p=linux/kernel/git/rostedt/linux-2.6-trace.git;a=commit;h=082605de5f82eb692cc90f7fda071cc01bb5ac34

-Lee
