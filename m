Return-Path: <jostein.pettersen@westerngeco.com>
Received: from mail.slb.com (eurmta02.montrouge.eur.slb.com [163.187.152.23])
	by ozlabs.org (Postfix) with ESMTP id CE9C52BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 07:30:09 +1100 (EST)
Received: from pmxchannel-daemon.eurmta02.montrouge.eur.slb.com by
	eurmta02.montrouge.eur.slb.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	id <0IA600C0E69Y88@eurmta02.montrouge.eur.slb.com> for
	linuxppc-embedded@ozlabs.org; Tue, 11 Jan 2005 20:29:58 +0000 (GMT)
Received: from wgmail3.oslo.eur.slb.com
	(wgmail3.oslo.eur.slb.com [134.32.44.153]) by
	eurmta02.montrouge.eur.slb.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0IA600K5F69NVM@eurmta02.montrouge.eur.slb.com> for
	linuxppc-embedded@ozlabs.org; Tue, 11 Jan 2005 20:29:48 +0000 (GMT)
Date: Tue, 11 Jan 2005 21:29:38 +0100
From: Jostein Pettersen <jostein.pettersen@westerngeco.com>
To: linuxppc-embedded@ozlabs.org
Message-id: <5.1.0.14.2.20050111210842.024ca490@wgmail3.oslo.eur.slb.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Cc: Tormod Tjaberg <ttjaberg@oslo.westerngeco.slb.com>
Subject: Linux hangs after early_init()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to get Linux (2.4.19) up and running on a BMW board (from 
Broadcom) with a 8245 processor. I'm using ppcboot 1.2.0.

I've found that early_init() in setup.c does not return. Everything is ok 
up until the very end of early_init().

Something very basic must be wrong. I would be happy for some some pointers 
as to what this could be!

Cheers,
Jostein Pettersen
