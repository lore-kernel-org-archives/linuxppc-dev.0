Return-Path: <bsingharora@gmail.com>
Received: from mail-qt0-x231.google.com (mail-qt0-x231.google.com
 [IPv6:2607:f8b0:400d:c0d::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjQg268R6zDqKY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 21:04:30 +1000 (AEST)
Received: by mail-qt0-x231.google.com with SMTP id u19so5015931qta.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jun 2017 04:04:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9c856cc0-4a3d-c59f-5215-63437187a289@c-s.fr>
References: <201706040706.WevfghQQ%fengguang.wu@intel.com>
 <9c856cc0-4a3d-c59f-5215-63437187a289@c-s.fr>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 7 Jun 2017 21:04:27 +1000
Message-ID: <CAKTCnz=xfSCZLP6cUpuqiGje37JeT3Pu56Kdb1U2r+voukPK5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] powerpc/lib/code-patching: Enhance code patching
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Paul Mackerras <paulus@samba.org>, kbuild-all@01.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Laura Abbott <labbott@redhat.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Rashmica Gupta <rashmica.g@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 7, 2017 at 8:25 PM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
> Hi Balbir
>
> Le 04/06/2017 =C3=A0 01:45, kbuild test robot a =C3=A9crit :
>>
>> Hi Balbir,
>>
>> [auto build test ERROR on powerpc/next]
>> [also build test ERROR on v4.12-rc3 next-20170602]
>> [if your patch is applied to the wrong git tree, please drop us a note t=
o
>> help improve the system]
>>
>> url:
>> https://github.com/0day-ci/linux/commits/Balbir-Singh/Enable-STRICT_KERN=
EL_RWX/20170603-161759
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.gi=
t
>> next
>> config: powerpc-kilauea_defconfig (attached as .config)
>> compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
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
>>     arch/powerpc/lib/code-patching.c: In function 'kernel_map_addr':
>>>>
>>>> arch/powerpc/lib/code-patching.c:93:8: error: implicit declaration of
>>>> function 'map_kernel_page' [-Werror=3Dimplicit-function-declaration]
>>
>>       err =3D map_kernel_page(
>>             ^~~~~~~~~~~~~~~
>>     cc1: all warnings being treated as errors
>
>
> You should probably include my patch (the one renaming map_page() to
> map_kernel_page() ) in as first patch in your serie in order to get a cle=
an
> serie and avoid such reports from the robot.
>
> Christophe

Thanks for the suggestion, I did in my cover letter mention the
pre-requisite is your patch. I'll keep that in mind if there is a v4,
otherwise, we'll need to pull in your patch first and then apply this
series.

Balbir Singh.
