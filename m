Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x232.google.com (mail-oi0-x232.google.com
 [IPv6:2607:f8b0:4003:c06::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rR65z1LsczDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 01:48:39 +1000 (AEST)
Received: by mail-oi0-x232.google.com with SMTP id p204so118201323oih.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 08:48:39 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1465559513.32231.2.camel@ellerman.id.au>
References: <1465559513.32231.2.camel@ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 Jun 2016 08:48:36 -0700
Message-ID: <CA+55aFyn9_q08QCPohiSL5snQjinaqm9rZRvHz2OVd0zzjWaXg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.7-3 tag
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>,
 gwshan@linux.vnet.ibm.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@ozlabs.org>,
 raj.khem@gmail.com,
 ruscur@russell.cc, thuth@redhat.com, Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 10, 2016 at 4:51 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> powerpc fixes for 4.7 #2

This is actually #3 - and some of the things you describe came in
already through #2.

Do you mind double-checking your descriptions? Which of these are
actually new? I'd like to get my merge message correct, and I suspect
you're partly describing things that already got merged (I know the
shortlog and the diffstat were that way, I don't know if your
description in the tag was)

                 Linus
