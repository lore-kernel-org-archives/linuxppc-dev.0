Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id D46D4DDE9A
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 08:49:43 +1000 (EST)
Received: from pd4mr3so.prod.shaw.ca
	(pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPX00D27BCCWW80@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 14 Oct 2007 16:48:12 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPX002N0BC9DY60@pd4mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sun, 14 Oct 2007 16:48:12 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPX00052BC88HA0@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 14 Oct 2007 16:48:08 -0600 (MDT)
Date: Sun, 14 Oct 2007 16:48:08 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v3 0/7] Respin of bestcomm patches
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org,
	tnt@246tnt.com, domen.puncer@telargo.com
Message-id: <20071014224724.14235.96152.stgit@trillian.cg.shawcable.net>
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

v3 fixes a regression building modules and integrates Domen's changes to
the FEC task.

Cheers,
g.
--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
