Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C83D667A64
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 17:34:59 +1000 (EST)
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673064DA761@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673064DA761@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Fri, 26 May 2006 17:34:47 +1000
Message-Id: <1148628888.8089.109.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Alexandre.Bounine@tundra.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> What should  we do? 
> Can we  keep the map table unitl your code 
> is OK?

Or you could have your platform-specific fixup_irq walk the
interrupt-map property in the tree, still better than a table and allows
you to validate the tree. When my code is fixed, you can then just
remove your fixup.

Ben.
