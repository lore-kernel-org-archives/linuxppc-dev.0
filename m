Return-Path: <srs0=g6dx=3t=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2HxW3qYbzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 17:00:15 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w2HxW32V2z8wFX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 17:00:15 +1000 (AEST)
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w2HxV41wnz9sNS
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 17:00:13 +1000 (AEST)
Received: by mail-pf0-x232.google.com with SMTP id o126so44499251pfb.3
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 00:00:13 -0700 (PDT)
Message-ID: <1491894007.8380.0.camel@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/tracing: Trace TLBIE(L)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au, linuxppc-dev@ozlabs.org
Date: Tue, 11 Apr 2017 17:00:07 +1000
In-Reply-To: <20170411052325.20206-1-bsingharora@gmail.com>
References: <20170411052325.20206-1-bsingharora@gmail.com>
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

On Tue, 2017-04-11 at 15:23 +1000, Balbir Singh wrote:
> Just a quick patch to trace tlbie(l)'s. The idea being that it can be
> enabled when we suspect corruption or when we need to see if we are doing
> the right thing during flush. I think the format can be enhanced to
> make it nicer (expand the RB/RS/IS/L cases in more detail if we ever
> need that level of details).

The subject is misleading this is not PATCH 1/2, but should read
[PATCH v2]. Sorry! I can resend this if required

Balbir
