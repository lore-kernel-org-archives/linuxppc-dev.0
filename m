Return-Path: <bobby.prani@gmail.com>
Received: from mail-yk0-x233.google.com (mail-yk0-x233.google.com
 [IPv6:2607:f8b0:4002:c07::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE8661A006C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 12:06:29 +1100 (AEDT)
Received: by mail-yk0-x233.google.com with SMTP id z7so56100290yka.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jan 2016 17:06:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CANtoAtNkjrJfac0nR7ay7LKToMf53KtpVZNv0+xabHn1QSwRkA@mail.gmail.com>
References: <CANtoAtNkjrJfac0nR7ay7LKToMf53KtpVZNv0+xabHn1QSwRkA@mail.gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Sun, 31 Jan 2016 20:05:58 -0500
Message-ID: <CAJhHMCA6wy=i=yD4S-D0-vRTAOadTbwEtarsawK0BLw23G2Shg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Failure_on_latest_GIT_=2D_implicit_declaration_of_?=
 =?UTF-8?Q?function_=E2=80=98pte=5Fswp=5Fclear=5Fsoft=5Fdirty=E2=80=99?=
To: Mike <michael.heltne@gmail.com>
Cc: "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 31, 2016 at 8:01 PM, Mike <michael.heltne@gmail.com> wrote:
> Building on ppc32
>
> In file included from fs/proc/task_mmu.c:14:0:
> include/linux/swapops.h: In function =E2=80=98pte_to_swp_entry=E2=80=99:
> include/linux/swapops.h:69:6: error: implicit declaration of function
> =E2=80=98pte_swp_soft_dirty=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
>   if (pte_swp_soft_dirty(pte))
>       ^
> include/linux/swapops.h:70:9: error: implicit declaration of function
> =E2=80=98pte_swp_clear_soft_dirty=E2=80=99 [-Werror=3Dimplicit-function-d=
eclaration]
>    pte =3D pte_swp_clear_soft_dirty(pte);
>          ^

Can you try the patch posted here: https://lkml.org/lkml/2016/1/25/554

Thanks!
--=20
Pranith
