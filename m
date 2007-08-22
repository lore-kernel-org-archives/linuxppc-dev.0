Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 6DFABDDFF9
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 03:50:55 +1000 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 2D0E52232C1
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 19:50:53 +0200 (CEST)
Received: from ibook.aepfle.de (DSL01.83.171.157.120.ip-pool.NEFkom.net
	[83.171.157.120])
	by mail.mnet-online.de (Postfix) with ESMTP id 24E1A903FA
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 19:50:53 +0200 (CEST)
Date: Wed, 22 Aug 2007 19:51:21 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: bogus vscsi dt node on iseries
Message-ID: <20070822175121.GA21233@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Does anyone know why dt_vdevices() creates a vscsi node on legacy iseries?
I'm sure only viodasd and viocd is required as blockdevice type.
