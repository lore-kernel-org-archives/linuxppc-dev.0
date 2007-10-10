Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 075F1DE013
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 04:32:26 +1000 (EST)
Received: from pd3mr3so.prod.shaw.ca
	(pd3mr3so-qfe3.prod.shaw.ca [10.0.141.179]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPP00053KSPHND0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 10 Oct 2007 12:31:37 -0600 (MDT)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd3mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPP000QWKSPJX60@pd3mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 10 Oct 2007 12:31:37 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPP00L6VKSOU2X0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 10 Oct 2007 12:31:36 -0600 (MDT)
Date: Wed, 10 Oct 2007 12:31:40 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/3] More XilinxFB changes
To: linux-fbdev-devel@lists.sourceforge.net, akonovalov@ru.mvista.com,
	linuxppc-dev@ozlabs.org, adaplas@gmail.com, jwboyer@linux.vnet.ibm.com
Message-id: <20071010182920.12852.41903.stgit@trillian.cg.shawcable.net>
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

Here are some more changes on the xilinxfb driver.  These changes add the
ability to specify a custom resolution or framebuffer physical address.
Useful for FPGA designs which use a modified xilinxfb device.

Please review and comment.

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
