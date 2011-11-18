Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 84FE0B7233
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2011 05:09:00 +1100 (EST)
Received: from mail9-db3 (localhost [127.0.0.1])	by mail9-db3-R.bigfish.com
 (Postfix) with ESMTP id 06B736A0106	for <linuxppc-dev@ozlabs.org>; Fri, 18
 Nov 2011 18:08:45 +0000 (UTC)
Received: from DB3EHSMHS017.bigfish.com (unknown [10.3.81.243])	by
 mail9-db3.bigfish.com (Postfix) with ESMTP id DB8DD1A0042	for
 <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 18:08:44 +0000 (UTC)
Message-ID: <4EC69F35.9060207@freescale.com>
Date: Fri, 18 Nov 2011 12:08:53 -0600
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
 <4EC68F14.9020206@freescale.com>
 <20111118180651.GC28562@schlenkerla.am.freescale.net>
In-Reply-To: <20111118180651.GC28562@schlenkerla.am.freescale.net>
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
> What's wrong with doing it in setup_arch()?

Well, I was hoping to encapsulate everything into one function -- the early_param() callback function.  But I guess that's not going to work.

-- 
Timur Tabi
Linux kernel developer at Freescale
