Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x22c.google.com (mail-vk0-x22c.google.com
 [IPv6:2607:f8b0:400c:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFnBP29SLzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 16:36:45 +1100 (AEDT)
Received: by mail-vk0-x22c.google.com with SMTP id c76so6934777vkd.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 22:36:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87po9nllfu.fsf@concordia.ellerman.id.au>
References: <20170929042655.14570-1-bsingharora@gmail.com>
 <20170929042655.14570-3-bsingharora@gmail.com>
 <87po9nllfu.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 16 Oct 2017 16:36:42 +1100
Message-ID: <CAKTCnzncKCZiRXZtVehhnoPXgLE59Oq0qsmGLBEg=6Zvts5f6g@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] powerpc/mce: align the print of physical address
 better
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 16, 2017 at 4:18 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> Use the same alignment as Effective address
>> and rename phyiscal address to Page Frame Number
>
> You didn't do the 2nd part AFAICS?
>
> Will fix it up.

Sorry the changelog is buggy :( Nick asked me to keep the physical address.
I should have removed the changes when I reverted the changes

Balbir
