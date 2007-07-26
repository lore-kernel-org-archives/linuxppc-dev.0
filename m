Return-Path: <brad@heeltoe.com>
Received: from gateway.heeltoe.com (gateway.heeltoe.com [66.134.219.32])
	by ozlabs.org (Postfix) with ESMTP id 4528ADDEF5
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 01:34:56 +1000 (EST)
Received: from mwave.heeltoe.com (mwave [192.245.4.20])
	by gateway.heeltoe.com (Postfix) with ESMTP id 6B56911409C
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 11:34:54 -0400 (EDT)
Received: from mwave.heeltoe.com (localhost.localdomain [127.0.0.1])
	by mwave.heeltoe.com (8.12.11.20060308/8.12.11) with ESMTP id
	l6QFYs8O024543
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 11:34:54 -0400
Received: from mwave (brad@localhost)
	by mwave.heeltoe.com (8.12.11.20060308/8.12.11/Submit) with ESMTP id
	l6QFYsUN024539
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 11:34:54 -0400
Message-Id: <200707261534.l6QFYsUN024539@mwave.heeltoe.com>
From: Brad Parker <brad@heeltoe.com>
To: linuxppc-dev@ozlabs.org
Subject: need help with 8247 config; bus errors, fcc underruns, etc...
Date: Thu, 26 Jul 2007 11:34:54 -0400
Sender: brad@heeltoe.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Anyone have direct experience setting up an 8247?

I need some help and am willing to pay for consulting.  Please contact
me directly if interested.

Basically I have u-boot running and it will load a kernel via ethernet
(fcc).  But once the kernel starts the FCC won't transmit packets bigger
than the fifo (192 bytes) - it gets underuns.  It seems to receive fine.
And once and a while it will crash with a machine check.  Or a TEA#
error.

I've done all the obvious things but no joy.  For some reason this one
doesn't act like the 8260 or 8248.

-brad

Brad Parker
Heeltoe Consulting
+1-781-483-3101
http://www.heeltoe.com
