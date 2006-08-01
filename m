Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 15432679E0
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 06:36:46 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k71KaiLL003851
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Aug 2006 13:36:44 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k71Kagvo015183
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Aug 2006 15:36:43 -0500 (CDT)
Subject: RFC: Location for Device Tree Sources?
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1154464346.19994.4.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 01 Aug 2006 15:32:26 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Folks,

Where should we place the sources for the OF Flat Device
Tree source files?  They used to be in U-Boot, but that
isn't happening any more.

One semi-obvious place would be to co-locate them with
their corresponding Linux arch/powerpc/platform directory.
Another would be to have a new directory full of them
under, say, arch/powerpc/devtrees or so.

Are there other suggestions or better ideas?

Thanks,
jdl
