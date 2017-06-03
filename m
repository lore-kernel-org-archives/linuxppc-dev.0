Return-Path: <bsingharora@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfqhv680fzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Jun 2017 15:42:07 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id y201so7569126qka.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 22:42:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6dcd8ea3-e953-3319-0e0e-8543018e882f@c-s.fr>
References: <201705260000.CDMt1Ieh%fengguang.wu@intel.com>
 <6dcd8ea3-e953-3319-0e0e-8543018e882f@c-s.fr>
From: Balbir Singh <bsingharora@gmail.com>
Date: Sat, 3 Jun 2017 15:42:04 +1000
Message-ID: <CAKTCnzmeRsr8LcrP37A4qWzYv+A3xyNc5XXFQwLgEC08cZGGcg@mail.gmail.com>
Subject: Re: [PATCH v1 7/8] powerpc/Kconfig: Enable STRICT_KERNEL_RWX
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: kbuild test robot <lkp@intel.com>, Laura Abbott <labbott@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Paul Mackerras <paulus@samba.org>, kbuild-all@01.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Rashmica Gupta <rashmica.g@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 29, 2017 at 6:00 PM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 25/05/2017 =C3=A0 18:45, kbuild test robot a =C3=A9crit :
>>
>> Hi Balbir,
>>
>> [auto build test ERROR on powerpc/next]
>> [also build test ERROR on v4.12-rc2 next-20170525]
>> [if your patch is applied to the wrong git tree, please drop us a note t=
o
>> help improve the system]
>>
>> url:
>> https://github.com/0day-ci/linux/commits/Balbir-Singh/Enable-STRICT_KERN=
EL_RWX/20170525-150234
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.gi=
t
>> next
>> config: powerpc-allmodconfig (attached as .config)
>> compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>          wget
>> https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross=
 -O
>> ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # save the attached .config to linux build tree
>>          make.cross ARCH=3Dpowerpc
>>
>> All errors (new ones prefixed by >>):
>>
>>>> kernel//power/snapshot.c:40:28: fatal error: asm/set_memory.h: No such
>>>> file or directory
>>
>>      #include <asm/set_memory.h>
>
>
> Looks like it is linked to commit 50327ddfb ("kernel/power/snapshot.c: us=
e
> set_memory.h header").
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D50327ddfb
>
> I believe that inclusion should be conditional to
> CONFIG_ARCH_HAS_SET_MEMORY, which is not set by powerpc arch, just like i=
n
> include/linux/filter.c
>
> Christophe
>
>
Agreed, it needs to be fixed in kernel/power/sanpshot.c

Balbir Singh
