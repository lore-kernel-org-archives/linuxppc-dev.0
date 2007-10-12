Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 8D562DE040
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 16:01:46 +1000 (EST)
Received: from pd4mr2so.prod.shaw.ca
	(pd4mr2so-qfe3.prod.shaw.ca [10.0.141.213]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPS00JXUBEMQ880@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 12 Oct 2007 00:01:34 -0600 (MDT)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
	by pd4mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPS00B0HBEMEOC4@pd4mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 12 Oct 2007 00:01:35 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPS007T6BELTPA1@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 12 Oct 2007 00:01:33 -0600 (MDT)
Date: Fri, 12 Oct 2007 00:01:33 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/2] Fixups to powerpc tree.
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Message-id: <20071012055826.9718.2510.stgit@trillian.cg.shawcable.net>
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

Hi Paulus,

Here are 2 fixups to the powerpc tree.  The first is a change to
lite5200.c that somehow got dropped from the ROOT_DEV patch.  The
second is a simple typo fix to the xilinxfb driver.  (I had noticed
the typo after posting the patch, but had thought in the back of my
mind that I'd get to spin another version before they got merged)

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
