Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSVLX6lMyzDqZn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 20:05:24 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id h64so1246288pge.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 03:05:24 -0700 (PDT)
Message-ID: <1495015516.30802.9.camel@gmail.com>
Subject: Re: kernel BUG at mm/usercopy.c:72!
From: Balbir Singh <bsingharora@gmail.com>
To: Kees Cook <keescook@chromium.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Laura Abbott <labbott@redhat.com>,
 gromero@br.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 20:05:16 +1000
In-Reply-To: <CAGXu5jK86RkgsWFdtSuGoZzuRZt4cqJcU4YSTjn=irv0Pbu3Rw@mail.gmail.com>
References: <20170515191949.GA13641@gmail.com>
 <878tlxoy62.fsf@concordia.ellerman.id.au>
 <CAGXu5jK86RkgsWFdtSuGoZzuRZt4cqJcU4YSTjn=irv0Pbu3Rw@mail.gmail.com>
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

> > Kees, depending on how that turns out we may ask you to revert
> > 517e1fbeb65f ("mm/usercopy: Drop extra is_vmalloc_or_module() check").
> 
> That's fine by me. Let me know what you think would be best.
> 
> Laura, I don't see much harm in putting this back in place. It seems
> like it's just a matter of efficiency to have it removed?

It looks like we resolved struct page of 0xd000000003d80030 as PageSlab?

Balbir Singh.
