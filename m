Return-Path: <arndbergmann@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40MBzP34TBzDqyp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 17:16:32 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id s48so5105113qtb.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 00:16:32 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CA+55aFx4_gaBeffy9roFRnkB30fnRa=nhh5qR=o=CgrWmgphiw@mail.gmail.com>
References: <CAK8P3a081_hkr5d0FRWpTaT-AsJoqznsS1=_WF4JVLTUOupUgg@mail.gmail.com>
 <CA+55aFx4_gaBeffy9roFRnkB30fnRa=nhh5qR=o=CgrWmgphiw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 12 Apr 2018 09:16:30 +0200
Message-ID: <CAK8P3a2brHyWJx=WwXgxr3Gkouu5DAgqBvBQiz0rcPvZ18xO8g@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic fixes for v4.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sinan Kaya <okaya@codeaurora.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Ley Foon Tan <lftan@altera.com>,
 "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>,
 Michal Simek <monstr@monstr.eu>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 sparclinux <sparclinux@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 12, 2018 at 1:16 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Apr 11, 2018 at 8:40 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> are available in the git repository at:
>>
>>   git+ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
>> tags/asm-generic
>
> Yeah, no they aren't available there at all.
>
> That tag is some old tag from two years ago that just contains your
> ancient "asm-generic: use compat version for preadv2 and pwritev2".
>
> Forgot to push out? Or forgot to use "-f" to overwrite the old tag?

Yes, something like that, I first tagged the local branch in the wrong
tree which had an old branch of the same name, noticed my mistake
as I pushed it, but then screwed up again when I tried to correct it:
I force-pushed the correct branch again, but not the tag.

Pushed the right tag now, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic

        Arnd
