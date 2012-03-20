Return-Path: <richard.weinberger@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 259B6B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 00:36:13 +1100 (EST)
Received: by obbun3 with SMTP id un3so19092obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 06:36:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFPAmTSzV9mrkbP68p4PA-0i0o2Hz7JiBY=0A0V_myJEzWubjQ@mail.gmail.com>
References: <CAFPAmTQs9dOpQTaXU=6Or66YU+my_CnPw33TE4h++YArBNa38g@mail.gmail.com>
 <CAFLxGvwW2XcYSoidZZ0XF_a-pH3SwONqS+hCnpGUecQ__DLa_g@mail.gmail.com>
 <CAFPAmTSzV9mrkbP68p4PA-0i0o2Hz7JiBY=0A0V_myJEzWubjQ@mail.gmail.com>
Date: Tue, 20 Mar 2012 14:36:06 +0100
Message-ID: <CAFLxGvyVbDndbu_2ZbUBwbrJCq+d4rRZW0ROxTpQxAvetRm=0w@mail.gmail.com>
Subject: Re: [PATCH 0/20] mmu: arch/mm: Port OOM changes to arch page fault
 handlers.
From: richard -rw- weinberger <richard.weinberger@gmail.com>
To: Kautuk Consul <consul.kautuk@gmail.com>
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

On Tue, Mar 20, 2012 at 2:34 PM, Kautuk Consul <consul.kautuk@gmail.com> wrote:
>>
>> What about arch/um/?
>> Does UML not need this change?
>
> Oh yes, extremely sorry I accidentally missed that one out.
> Mind if I send it separately ?

No problem.
handle_page_fault() is the function you want to patch. :)

-- 
Thanks,
//richard
