Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 34FBFDDE18
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 04:15:42 +1000 (EST)
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP300ASOC22X1B0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:15:38 -0600 (MDT)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
	by pd3mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP3009UNC21VW10@pd3mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Sep 2007 12:15:38 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP3004CMC215F40@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:15:37 -0600 (MDT)
Date: Fri, 28 Sep 2007 12:15:45 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 00/18] Virtex support in arch/powerpc
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series adds Xilinx Virtex support to arch/powerpc.  Please review
and comment.  It includes support for the uartlite and SystemACE devices

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
