Return-Path: <B11780@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 65BA8B6F81
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 19:26:04 +1000 (EST)
From: Kumar Gala <kumar.gala@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Subject: hotplug support on 85xx smp ?
Date: Fri, 8 Apr 2011 04:25:54 -0500
Message-ID: <1C7D8EDC-17F4-4A7B-AF3F-DF1DA71C0570@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0 (Apple Message framework v1084)
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

If looks like SUSPEND support requires CPU hotplug (forces =
CONFIG_HOTPLUG_CPU).  This is causing current 2.6.39-rc2 to break for =
85xx-smp.  Are you willing to take patches that add cpu hotplug support =
for 85xx/e500 for 2.6.39 to fix this?

- k=
