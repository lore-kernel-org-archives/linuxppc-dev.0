Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlhd31zXzzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 10:39:18 +1000 (AEST)
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 13 Apr 2016 21:39:12 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id DCF391DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 20:39:02 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3DNarSH4796486
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 20:36:53 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3E0d7Sb031011
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 20:39:07 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 kbuild-all@01.org
Subject: Re: [PATCH] ftrace: filter: Match dot symbols when searching
 functions on ppc64.
Date: Wed, 13 Apr 2016 21:39 -0300
Message-ID: <2596502.8PPJLykyZv@hactar>
In-Reply-To: <3507082.VaWR3lh7Ni@hactar>
References: <201604020331.kEOeyhX0%fengguang.wu@intel.com>
 <3507082.VaWR3lh7Ni@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Am Freitag, 01 April 2016, 18:28:06 schrieb Thiago Jung Bauermann:
> Am Samstag, 02 April 2016, 03:51:21 schrieb kbuild test robot:
> > >> arch/powerpc/include/asm/ftrace.h:62:5: error: "CONFIG_PPC64" is=
 not
> > >> defined [-Werror=3Dundef]
> > >>=20
> >     #if CONFIG_PPC64 && (!defined(_CALL_ELF) || _CALL_ELF !=3D 2)
> >    =20
> >         ^
> >   =20
> >    cc1: all warnings being treated as errors
>=20
> I forgot to use defined() in the #if expression. Here=E2=80=99s the f=
ixed version.

People seem to be considering patches for next, so this looks like a go=
od=20
moment to ping about this one.

Ps: patchwork seems to have an issue which causes it to show the messag=
e=20
body as if it were the commit message, but if you feed my original emai=
l=20
(the one I=E2=80=99m replying to here) to git am, the commit message wi=
ll be=20
correct.

--=20
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
