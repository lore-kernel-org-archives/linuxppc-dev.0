Return-Path: <consul.kautuk@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1FFBB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 00:34:50 +1100 (EST)
Received: by ggni2 with SMTP id i2so32257ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 06:34:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwW2XcYSoidZZ0XF_a-pH3SwONqS+hCnpGUecQ__DLa_g@mail.gmail.com>
References: <CAFPAmTQs9dOpQTaXU=6Or66YU+my_CnPw33TE4h++YArBNa38g@mail.gmail.com>
 <CAFLxGvwW2XcYSoidZZ0XF_a-pH3SwONqS+hCnpGUecQ__DLa_g@mail.gmail.com>
Date: Tue, 20 Mar 2012 09:34:41 -0400
Message-ID: <CAFPAmTSzV9mrkbP68p4PA-0i0o2Hz7JiBY=0A0V_myJEzWubjQ@mail.gmail.com>
Subject: Re: [PATCH 0/20] mmu: arch/mm: Port OOM changes to arch page fault
 handlers.
From: Kautuk Consul <consul.kautuk@gmail.com>
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-am33-list@redhat.com,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-sh@vger.kernel.org,
 microblaze-uclinux@itee.uq.edu.au, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-m68k@lists.linux-m68k.org, linux@lists.openrisc.net,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> What about arch/um/?
> Does UML not need this change?

Oh yes, extremely sorry I accidentally missed that one out.
Mind if I send it separately ?

>
> --
> Thanks,
> //richard
