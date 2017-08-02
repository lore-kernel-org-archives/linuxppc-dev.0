Return-Path: <dja@axtens.net>
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMYkh11LkzDrjD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 10:20:59 +1000 (AEST)
Received: by mail-pf0-x232.google.com with SMTP id t86so14018183pfe.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 17:20:59 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v5 2/2] raid6/altivec: Add vpermxor implementation for raid6 Q
 syndrome
In-Reply-To: <20170428055809.2675-2-matthew.brown.dev@gmail.com>
References: <20170428055809.2675-1-matthew.brown.dev@gmail.com>
 <20170428055809.2675-2-matthew.brown.dev@gmail.com>
Date: Wed, 02 Aug 2017 10:20:43 +1000
Message-ID: <87379astus.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oh, one final thing - I just realised there's a .gitignore file in
lib/raid6/.gitignore that needs to be updated to include the vpermxor
generated files. That should be part of this patch.

Regards,
Daniel
