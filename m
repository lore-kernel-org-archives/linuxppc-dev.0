Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rRBxt2CgTzDqQw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 05:26:57 +1000 (AEST)
Received: by mail-oi0-x241.google.com with SMTP id d132so15013056oig.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 12:26:57 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFyn9_q08QCPohiSL5snQjinaqm9rZRvHz2OVd0zzjWaXg@mail.gmail.com>
References: <1465559513.32231.2.camel@ellerman.id.au>
 <CA+55aFyn9_q08QCPohiSL5snQjinaqm9rZRvHz2OVd0zzjWaXg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 Jun 2016 12:26:55 -0700
Message-ID: <CA+55aFy3=ErnkbPmv7Ti1X=SA2i2a7xUv=opiQKW==ZMjSoK2A@mail.gmail.com>
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

On Fri, Jun 10, 2016 at 8:48 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jun 10, 2016 at 4:51 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> powerpc fixes for 4.7 #2
>
> This is actually #3 - and some of the things you describe came in
> already through #2.
>
> Do you mind double-checking your descriptions?

I double-checked it. Your diffstat and shortlog were out of date (and
your #2 in the tag message was wong), but your individual descriptions
matched the actual new commits.

           Linus
