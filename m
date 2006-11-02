Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 6D33667EBC
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 00:31:33 +1100 (EST)
Received: from leda.ptxnet.pengutronix.de ([10.1.0.71])
	by metis.extern.pengutronix.de with esmtp (Exim 3.36 #1 (Debian))
	id 1Gfc7O-0004e3-00
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Nov 2006 13:56:26 +0100
Received: from sha by leda.ptxnet.pengutronix.de with local (Exim 4.63)
	(envelope-from <sha@localhost.localdomain>) id 1Gfc7M-000563-0s
	for linuxppc-dev@ozlabs.org; Thu, 02 Nov 2006 13:56:24 +0100
Message-Id: <20061102125555.252338000@localhost.localdomain>
Date: Thu, 02 Nov 2006 13:55:55 +0100
From: s.hauer@pengutronix.de
To: linuxppc-dev@ozlabs.org
Subject: [patch 00/16] powerpc cleanup patches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

The following patchset contains various powerpc cleanup patches. Most of
them aim at reducing the usage of CONFIG_PPC_MULTIPLATFORM. Some patches
are trivial, others might cause objections.
Some patches have to go to subsystem maintainers, but I post them here
for review first.

Please comment

Sascha

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
