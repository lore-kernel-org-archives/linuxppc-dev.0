Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 379E8DDF22
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 21:29:57 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LDG8e-0006nN-Eu
	for linuxppc-dev@ozlabs.org; Thu, 18 Dec 2008 02:29:52 -0800
Message-ID: <21070179.post@talk.nabble.com>
Date: Thu, 18 Dec 2008 02:29:52 -0800 (PST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: Long boot delay on 460EX with 2.6.28-rc8
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

I'm experiencing a long (around 20 sec) delay from the moment
u-boot-1.3.4 passes control to linux and until the first kernel message
appears on console. This happens on custom board, I don't have access
to Canyonlands to test how it behaves. I did not modify anything in kernel 
code to make it boot on custom board, just removed PCIX and PCIE0 nodes
from DTS.

Has anyone experienced similar behavior with 460EX ? Any hints what can
cause this ?

Thanks a lot.

Felix.


-- 
View this message in context: http://www.nabble.com/Long-boot-delay-on-460EX-with-2.6.28-rc8-tp21070179p21070179.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
