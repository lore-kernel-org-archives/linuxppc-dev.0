Return-Path: <jrigby@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89476DDF82
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 04:30:06 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m0SHSw0r006178
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 10:28:58 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-168.am.freescale.net
	[10.214.72.168])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0SHSvfa011209
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 11:28:57 -0600 (CST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [Add mpc5121 support PATCH v4 0/4] Basic Freescale MPC512x support
Date: Mon, 28 Jan 2008 10:28:52 -0700
Message-Id: <1201541336-28676-1-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

New patches set hopefully for 2.6.25
Changes since v3
First four patches have already gone in via Grant and Kumar

1/4 Basic-Freescale-MPC512x-support.patch
    Previously Acked-by: Grant Likely <grant.likely@secretlab.ca>

2/4 Device-tree-for-MPC5121-ADS.patch
    Updated to /dts-v1/

3/4 Factor out 5200 dependencies from 52xx psc driver
    Fixed problem on no output in userland

4/4 Add MPC512x support to MPC52xx psc driver
    No changes since v3
