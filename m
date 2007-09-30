Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 4F4EADDF32
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 07:47:26 +1000 (EST)
Received: from pd3mr3so.prod.shaw.ca
	(pd3mr3so-qfe3.prod.shaw.ca [10.0.141.179]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP700KQ9B63OC00@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 15:46:51 -0600 (MDT)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
	by pd3mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP700JQKB63NR40@pd3mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sun, 30 Sep 2007 15:46:51 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP700M62B61RPY0@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 15:46:50 -0600 (MDT)
Date: Sun, 30 Sep 2007 15:46:49 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/3] Bug fixes to Virtex support in arch/ppc
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Message-id: <20070930214140.31899.55951.stgit@trillian.cg.shawcable.net>
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

Josh,

Here are some small bug fixes to arch/ppc.  They are all pretty trivial,
and I think they should go in for 2.6.24.  If there are no problems with
them, can you please merge them into your tree and ask paulus to pull
them?

In particular, I'd like to see the xilinxfb patch go in ASAP.  I've got
a set of xilinxfb patches to make it work for arch/powerpc; but the move
of the platform_data structure must happen first, otherwise compilation
will fail.  Once it's merged, I'll post the xilinxfb patches to the
linux-fbdev mailing list.

Cheers,
g.
--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
