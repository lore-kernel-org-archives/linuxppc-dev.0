Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 87EB1DE0CA
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 04:05:45 +1100 (EST)
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JUU008A4NGFAB80@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 18 Jan 2008 10:05:03 -0700 (MST)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd3mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JUU0087QNGDL0A0@pd3mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 18 Jan 2008 10:05:01 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JUU0080LNGEOT70@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 18 Jan 2008 10:05:02 -0700 (MST)
Date: Fri, 18 Jan 2008 10:04:37 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC/PATCH 0/2] mpc5200: tidy up the device tree bindings
To: linuxppc-dev@ozlabs.org, jrigby@freescale.com, matt@genesi-usa.com,
	tnt@246tnt.com
Message-id: <20080118170324.10592.47360.stgit@trillian.secretlab.ca>
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

These two patches make the device tree bindings for 5200 platforms more
robust and match closer with the generic names recommended practice.

Please review and comment.

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
