Return-Path: <michael.heltne@gmail.com>
Received: from mail-yk0-x230.google.com (mail-yk0-x230.google.com
 [IPv6:2607:f8b0:4002:c07::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A7431A006C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 12:01:41 +1100 (AEDT)
Received: by mail-yk0-x230.google.com with SMTP id z7so56004621yka.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jan 2016 17:01:41 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 1 Feb 2016 01:01:38 +0000
Message-ID: <CANtoAtNkjrJfac0nR7ay7LKToMf53KtpVZNv0+xabHn1QSwRkA@mail.gmail.com>
Subject: =?UTF-8?Q?Failure_on_latest_GIT_=2D_implicit_declaration_of_func?=
 =?UTF-8?Q?tion_=E2=80=98pte=5Fswp=5Fclear=5Fsoft=5Fdirty=E2=80=99?=
From: Mike <michael.heltne@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=94eb2c08233459dd3e052aaaedb7
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c08233459dd3e052aaaedb7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Building on ppc32

In file included from fs/proc/task_mmu.c:14:0:
include/linux/swapops.h: In function =E2=80=98pte_to_swp_entry=E2=80=99:
include/linux/swapops.h:69:6: error: implicit declaration of function
=E2=80=98pte_swp_soft_dirty=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]
  if (pte_swp_soft_dirty(pte))
      ^
include/linux/swapops.h:70:9: error: implicit declaration of function
=E2=80=98pte_swp_clear_soft_dirty=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
   pte =3D pte_swp_clear_soft_dirty(pte);
         ^
  if [ "-pg" =3D "-pg" ]; then set -e ; perl ./scripts/recordmcount.pl
"powerpc" "big" "32" "objdump" "objcopy" "gcc -mbig-endian -m32 -Wall
-Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
-Werror-implicit-function-declaration -Wno-format-security -std=3Dgnu89
-msoft-float -pipe -Iarch/powerpc -ffixed-r2 -mmultiple -mno-altivec
-mno-vsx -mno-spe -mspe=3Dno -funit-at-a-time -fno-dwarf2-cfi-asm -mno-stri=
ng
-mcpu=3Dpowerpc -mno-sched-epilog -Wa,-maltivec
-fno-delete-null-pointer-checks -O2 --param=3Dallow-store-data-races=3D0
-Wframe-larger-than=3D1024  -fno-stack-protector -Wno-unused-but-set-variab=
le
 -fno-var-tracking-assignments -pg  -Wdeclaration-after-statement
-Wno-pointer-sign -fno-strict-overflow -fconserve-stack
-Werror=3Dimplicit-int -Werror=3Dstrict-prototypes -Werror=3Ddate-time
-DCC_HAVE_ASM_GOTO    " "ld -EB -m elf32ppc" "nm" "" "" "0"
"fs/notify/inotify/inotify_user.o"; fi;
fs/proc/task_mmu.c: In function =E2=80=98pte_to_pagemap_entry=E2=80=99:
fs/proc/task_mmu.c:1158:7: error: implicit declaration of function
=E2=80=98pte_soft_dirty=E2=80=99 [-Werror=3Dimplicit-function-declaration]

--94eb2c08233459dd3e052aaaedb7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Building on ppc32=C2=A0</div><div><br></div><div>In f=
ile included from fs/proc/task_mmu.c:14:0:</div><div>include/linux/swapops.=
h: In function =E2=80=98pte_to_swp_entry=E2=80=99:</div><div>include/linux/=
swapops.h:69:6: error: implicit declaration of function =E2=80=98pte_swp_so=
ft_dirty=E2=80=99 [-Werror=3Dimplicit-function-declaration]</div><div>=C2=
=A0 if (pte_swp_soft_dirty(pte))</div><div>=C2=A0 =C2=A0 =C2=A0 ^</div><div=
>include/linux/swapops.h:70:9: error: implicit declaration of function =E2=
=80=98pte_swp_clear_soft_dirty=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]</div><div>=C2=A0 =C2=A0pte =3D pte_swp_clear_soft_dirty(pte);</div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^</div><div>=C2=A0 if [ &quot;-pg&quo=
t; =3D &quot;-pg&quot; ]; then set -e ; perl ./scripts/<a href=3D"http://re=
cordmcount.pl">recordmcount.pl</a> &quot;powerpc&quot; &quot;big&quot; &quo=
t;32&quot; &quot;objdump&quot; &quot;objcopy&quot; &quot;gcc -mbig-endian -=
m32 -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -=
fno-common -Werror-implicit-function-declaration -Wno-format-security -std=
=3Dgnu89 -msoft-float -pipe -Iarch/powerpc -ffixed-r2 -mmultiple -mno-altiv=
ec -mno-vsx -mno-spe -mspe=3Dno -funit-at-a-time -fno-dwarf2-cfi-asm -mno-s=
tring -mcpu=3Dpowerpc -mno-sched-epilog -Wa,-maltivec -fno-delete-null-poin=
ter-checks -O2 --param=3Dallow-store-data-races=3D0 -Wframe-larger-than=3D1=
024 =C2=A0-fno-stack-protector -Wno-unused-but-set-variable =C2=A0-fno-var-=
tracking-assignments -pg =C2=A0-Wdeclaration-after-statement -Wno-pointer-s=
ign -fno-strict-overflow -fconserve-stack -Werror=3Dimplicit-int -Werror=3D=
strict-prototypes -Werror=3Ddate-time -DCC_HAVE_ASM_GOTO =C2=A0 =C2=A0&quot=
; &quot;ld -EB -m elf32ppc&quot; &quot;nm&quot; &quot;&quot; &quot;&quot; &=
quot;0&quot; &quot;fs/notify/inotify/inotify_user.o&quot;; fi;</div><div>fs=
/proc/task_mmu.c: In function =E2=80=98pte_to_pagemap_entry=E2=80=99:</div>=
<div>fs/proc/task_mmu.c:1158:7: error: implicit declaration of function =E2=
=80=98pte_soft_dirty=E2=80=99 [-Werror=3Dimplicit-function-declaration]</di=
v><div><br></div></div>

--94eb2c08233459dd3e052aaaedb7--
