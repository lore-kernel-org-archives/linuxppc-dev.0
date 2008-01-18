Return-Path: <linuxppcdev@lists.qbjnet.com>
Received: from kunk.qbjnet.com (vci-113.dsl.onvoy.net [137.192.135.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F16D7DDF0B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 05:53:37 +1100 (EST)
Date: 18 Jan 2008 18:53:30 -0000
Message-ID: <20080118185330.8295.qmail@kunk.qbjnet.com>
From: Bob Brose <linuxppcdev@lists.qbjnet.com>
To: linuxppc-dev@ozlabs.org
Subject: l2cr missing from /proc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Why is l2cr missing from the /proc filesystem in recent 2.6 kernels?
Is it a bug or design decision?

It wasn't necessary since one could set it via a kernel arg however
now that I'm trying to turn on cache in a 7455 and setting l3cr isn't
supported from the command line I was wondering if l3cr was in /proc
as well but has also gone missing (since I see l3cr code in the kernel
source).
