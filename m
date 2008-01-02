Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id C446ADDE1B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 06:16:45 +1100 (EST)
Received: from pd2mr6so.prod.shaw.ca (pd2mr6so-qfe3.prod.shaw.ca [10.0.141.9])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JU1007ER6VWL320@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 02 Jan 2008 12:16:44 -0700 (MST)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd2mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JU100DH06S3ZFA0@pd2mr6so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 02 Jan 2008 12:14:28 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JU1003VP6S3X100@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 02 Jan 2008 12:14:27 -0700 (MST)
Date: Wed, 02 Jan 2008 12:14:18 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/5] Make platform code use machine_*_initcall() macros
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
	vitb@kernel.crashing.org, galak@kernel.crashing.org, olof@lixom.net
Message-id: <20080102191135.24178.99973.stgit@trillian.secretlab.ca>
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

This series makes the platform code use the new machine-specific initcall
hooks.  This has the advantage of not needing to explicitly test
machine_is() at the top of every initcall function.

This time I split the changes out into separate patches so each platform
maintainer can pick up the ones they are responsible for.  Please note;
these are untested as I don't have any of the hardware.

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
