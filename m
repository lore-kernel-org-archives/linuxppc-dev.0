Return-Path: <lagrange@fr.oleane.com>
Received: from smtp-out04.msg.oleane.net (smtp-out04.msg.oleane.net
	[62.161.7.2]) by ozlabs.org (Postfix) with ESMTP id DF240B7CE7
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Feb 2010 07:16:25 +1100 (EST)
Received: from smtp06.msg.oleane.net (smtp06.mail.priv [172.17.20.115])
	by smtp-out04.msg.oleane.net with ESMTP id o1BIwnDg010135
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 19:58:49 +0100
Received: from GEGE6600V (iconcept-gw.rain.fr [194.2.96.216]) (authenticated)
	by smtp06.msg.oleane.net (MTA) with ESMTP id o1BIca2I032180
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 19:38:37 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-dev@ozlabs.org>
Subject: TR: Linux 2.6.x 82xx probe devices with multiple serial drivers
Date: Thu, 11 Feb 2010 19:39:44 +0100
Message-ID: <000901caab49$98517d00$a501a8c0@GEGE6600V>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello,

I use a 82xx platform with a device tree which describes 4 SCC ports.
I want to probe these 4 SCC ports against 2 serial drivers (e.g. async and
sync).
Each port is declared as compatible with the 2 drivers.

When the first driver is loaded, all devices are probed and bound
with this driver and cannot be probed against the second driver.

I know that it can be a way to prevent against concurrent accesses but the
configuration is static and depends on how the drivers are loaded.

In fact, I want to load my 2 drivers, probe each entry without requesting
any resource then select how to open my ports using the first or second
driver.

Any tips ?
Thanks
Laurent
