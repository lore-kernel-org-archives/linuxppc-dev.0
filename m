Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 8B1CCDE1E1
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 14:15:15 +1000 (EST)
Received: from pd4mr2so.prod.shaw.ca
	(pd4mr2so-qfe3.prod.shaw.ca [10.0.141.213]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPD0092CD1U3OE0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 03 Oct 2007 22:13:06 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd4mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPD00L36D1TX700@pd4mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 03 Oct 2007 22:13:06 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPD00I9QD1TPG14@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 03 Oct 2007 22:13:05 -0600 (MDT)
Date: Wed, 03 Oct 2007 22:13:13 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/3] Fixups to SystemACE driver
To: jens.axboe@oracle.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Message-id: <20071004041114.20868.34605.stgit@trillian.cg.shawcable.net>
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

Jens,

Here are some more Sysace patches based on comments received on the
first series and a run through sparse.  Can you please queue them up
for 2.6.24?

Thanks,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
