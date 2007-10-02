Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 289D8DE01B
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 02:46:07 +1000 (EST)
Received: from pd2mr4so.prod.shaw.ca
	(pd2mr4so-qfe3.prod.shaw.ca [10.0.141.107]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPA00LAFMJ63K10@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 02 Oct 2007 10:45:06 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd2mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPA00LN2MJ6NL10@pd2mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Tue, 02 Oct 2007 10:45:06 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPA00K72MHXDG60@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 02 Oct 2007 10:44:21 -0600 (MDT)
Date: Tue, 02 Oct 2007 10:44:21 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/2] Uartlite: Revert register io access changes
In-reply-to: <20071002164415.24562.44426.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20071002164421.24562.33312.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071002164415.24562.44426.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Reverts commit 58205d2b1256a32c9e8b02587f8ef3cdcf1eb8bd

This driver is used by devices other than the xilinx opb-uartlite which
depend on bytewise access to the registers.  The change to 32 bit access
does not work on these devices.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 0 files changed, 0 insertions(+), 0 deletions(-)
