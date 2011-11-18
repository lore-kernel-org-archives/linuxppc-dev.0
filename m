Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1A66FB7218
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2011 04:00:13 +1100 (EST)
Received: from mail29-db3 (localhost [127.0.0.1])	by mail29-db3-R.bigfish.com
 (Postfix) with ESMTP id 4ABC5100103	for <linuxppc-dev@ozlabs.org>;
 Fri, 18 Nov 2011 16:59:55 +0000 (UTC)
Received: from DB3EHSMHS015.bigfish.com (unknown [10.3.81.248])	by
 mail29-db3.bigfish.com (Postfix) with ESMTP id 32BBD1C0042	for
 <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 16:59:55 +0000 (UTC)
Message-ID: <4EC68F14.9020206@freescale.com>
Date: Fri, 18 Nov 2011 11:00:04 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: p1022ds: enable monitor switching via
 pixis indirect mode
References: <1321556259-4459-1-git-send-email-timur@freescale.com>
 <1321556259-4459-2-git-send-email-timur@freescale.com>
 <20111117213733.GC14736@schlenkerla.am.freescale.net>
 <4EC586B2.5060604@freescale.com>
 <20111117222515.GA18827@schlenkerla.am.freescale.net>
 <4EC58AA0.2070905@freescale.com>
 <20111117224558.GA18848@schlenkerla.am.freescale.net>
In-Reply-To: <20111117224558.GA18848@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
>> > How do I update the device tree from platform code?

> prom_update_property()

I assume this needs to be called after the DT has been unflattened, since it takes a device_node* as a parameter.  Is there any way I can modify the tree before it's unflattened?  I'd like to fixup the tree in an early_param() function.

-- 
Timur Tabi
Linux kernel developer at Freescale
