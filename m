Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 72F0D1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2012 09:55:13 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: fix build failure from p1022 in SMP
 defconfig
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAP=VYLrjismj5PBfm=3LcVtC7pL4EXkt+JGKQNUuSJu1OU68MA@mail.gmail.com>
Date: Tue, 24 Jan 2012 16:55:00 -0600
Message-Id: <C8785E6B-CA31-4B61-91F5-97BEAE30D2E9@kernel.crashing.org>
References: <1327157528-12312-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLrjismj5PBfm=3LcVtC7pL4EXkt+JGKQNUuSJu1OU68MA@mail.gmail.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 21, 2012, at 9:50 AM, Paul Gortmaker wrote:

> On Sat, Jan 21, 2012 at 9:52 AM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
>> Using the configs/mpc85xx_smp_defconfig shows this build error:
>>=20
>> arch/powerpc/platforms/85xx/p1022_ds.c:341: error: 'udbg_progress' =
undeclared here (not in a function)
>>=20
>> Adding in the obvious missing header <asm/udbg.h> fixes it.
>=20
> I just noticed this fix is a duplicate, it seems that it was already
> queued back in Dec 11th last year:
>=20
> http://patchwork.ozlabs.org/patch/130620/
>=20
> ...but for one reason or another didn't make it into 3.3-rc1.
>=20
> P.

Ben just missed my pull request with it before 3.3-rc1.  Should get into =
rc2 or I'll have to get someone in ozlabs to beat ben for me ;)

- k=
