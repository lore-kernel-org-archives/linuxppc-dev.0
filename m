Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 2DE29DDFD6
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 14:28:17 +1000 (EST)
Received: from pd3mr3so.prod.shaw.ca
	(pd3mr3so-qfe3.prod.shaw.ca [10.0.141.179]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQC005EQKDT4FD0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 22 Oct 2007 22:27:29 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd3mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQC00CD4KDM1720@pd3mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 22 Oct 2007 22:27:30 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQC00227KDL8M23@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 22 Oct 2007 22:27:22 -0600 (MDT)
Date: Mon, 22 Oct 2007 22:27:25 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/4] Misc patches for the 2.6.24 merge window
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Message-id: <20071023042353.30309.93118.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus,

Here is the last set of patches that I'd like to get in before Linus
slams the merge window shut.  They're pretty minor changes.  The wrapper
patches make it easier to debug and catch errors and David has already
okayed them.  There's a speedup on the uartlite driver, and then a chunk
of documentation for the Xilinx device tree bindings.

Josh, can you please ack or nack the documentation change?

Peter, any issues with the uartlite change?

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
