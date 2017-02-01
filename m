Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vD8dt06k6zDq61
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 04:05:37 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 75so34671774pgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2017 09:05:37 -0800 (PST)
Message-ID: <1485968734.6360.154.camel@edumazet-glaptop3.roam.corp.google.com>
Subject: [RFC] implement QUEUED spinlocks on powerpc
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Kevin Hao <haokexin@gmail.com>, Torsten
 Duwe <duwe@suse.de>, Eric Dumazet <edumazet@google.com>
Date: Wed, 01 Feb 2017 09:05:34 -0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all

Is anybody working on adding QUEUED spinlocks to powerpc 64bit ?

I've seen past attempts with ticket spinlocks
( https://patchwork.ozlabs.org/patch/449381/ and other related links )

But it looks ticket spinlocks are a thing of the past.

Thanks.
