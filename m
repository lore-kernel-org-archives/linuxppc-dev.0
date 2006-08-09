Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id C12C167B55
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 11:23:40 +1000 (EST)
Date: Tue, 8 Aug 2006 20:22:03 -0500
From: Milton Miller <miltonm@bga.com>
To: jimix@watson.ibm.com, linuxppc-dev@ozlabs.org,
Subject: Re: [RFC] Debugging with a HW probe.
Message-Id: <311550865236b8b45674.846930886.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun Aug  6 2006 09:42:16 AM CDT, Jimi Xenidis wrote:
> On the XenPPC project we've been playing around with using GDB to
> source debug Linux (and Xen) using a RiscWatch HW probe.

> We have found it useful to teach xmon to make this call so we can then
> debug the SW thru the probe. Is this useful to anyone else

Since you only invoke the attention on command from the debugger, how
is this better than just invoking the stop command from the probe?  Is it you
are not dispatched out?  That you are not at a random point in the input
polling?

milton
