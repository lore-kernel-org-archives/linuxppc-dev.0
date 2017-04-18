Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6vsH5ChVzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 05:12:35 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id g2so341321pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 12:12:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/4 v2] cpufeatures merge candidate
Date: Wed, 19 Apr 2017 05:12:15 +1000
Message-Id: <20170418191220.3166-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I included binding documentation in OPAL, and wrote a design
overview and implementation guideline document. Writing updated
documentation lead to some small changes in the specification.

Also a number of other small changes to Linux and OPAL.

Thanks,
Nick
