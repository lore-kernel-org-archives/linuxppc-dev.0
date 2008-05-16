Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 503DFDEB0D
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 05:36:48 +1000 (EST)
Received: from pd4mr5so.prod.shaw.ca (pd4mr5so-qfe3.prod.shaw.ca [10.0.141.50])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0K0Z00LGS7RYL720@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 16 May 2008 13:35:59 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd4mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0K0Z0015X7RY9040@pd4mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 16 May 2008 13:35:59 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0K0Z001N77RYY040@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 16 May 2008 13:35:58 -0600 (MDT)
Date: Fri, 16 May 2008 13:35:57 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC PATCH 0/4] Describe SPI devices in the OF device tree and add
	mpc5200-spi driver
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
Message-id: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Cc: fabrizio.garetto@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series is a set of changes to allow the slaves on an SPI bus to be
described in the OF device tree (useful in arch/powerpc) and adds a driver
that uses it (the Freescale MPC5200 SoC's SPI device).

Please review and comment.  David, I've included in this series my earlier
patch to change modalias from a pointer to a string as one of the later
patches depends on it.

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
