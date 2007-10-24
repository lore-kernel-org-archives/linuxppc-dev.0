Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 62B16DE0A2
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 04:25:16 +1000 (EST)
Received: from pd2mr4so.prod.shaw.ca
	(pd2mr4so-qfe3.prod.shaw.ca [10.0.141.107]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQF0044UHSJJM30@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 24 Oct 2007 12:24:19 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd2mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQF00ASSHSJM640@pd2mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 24 Oct 2007 12:24:19 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQF002AYHSIOU20@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 24 Oct 2007 12:24:19 -0600 (MDT)
Date: Wed, 24 Oct 2007 12:24:20 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/2] mpc52xx: stop drivers from accessing clock config directly
To: domen.puncer@telargo.com, linuxppc-dev@ozlabs.org
Message-id: <20071024182308.21194.69416.stgit@trillian.cg.shawcable.net>
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

Domen,

Here's a real solution to the problem.  I've somewhat tested this on
the lite5200b.  Can you give it a spin on efika and see if SPI still
works for you?

Thanks,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
