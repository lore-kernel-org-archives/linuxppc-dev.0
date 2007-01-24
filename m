Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-55-245.msk.skylink.ru
	[83.217.55.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C53FDE01D
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:18:21 +1100 (EST)
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/3] 8560 && 8272 CPM-related fixes resubmit
Date: Wed, 24 Jan 2007 22:19:11 +0300
Message-ID: <20070124191552.3033.93568.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

All the points you've noticed are addressed here. 
Fs-enet change has been sent over to netdev && Jeff, so is excluded from here
this round, as well as cpm-uart, that is mandatory for CPM1 only and hereby
will be folded into upcoming 8xx series.
 
-- 
Sincerely, Vitaly
