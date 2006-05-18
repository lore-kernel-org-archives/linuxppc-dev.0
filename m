Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 282BC679FB
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 17:19:48 +1000 (EST)
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673062C05CC@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673062C05CC@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Thu, 18 May 2006 17:19:41 +1000
Message-Id: <1147936781.17679.103.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Well , should I register this data to a platform device or the Ethernet 
> driver get the information from device-tree directly?

You probably want to define a bus structure (/soc might work even if
it's not strictly a /soc) or use of_platform device to link a
device-tree node to a driver instance. You can create as many nodes as
you have devices and provide all the additional infos you need including
interrupt routing via the device-tree.

Ben.
