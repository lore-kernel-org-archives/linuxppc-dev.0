Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vQMl54xwCzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 19:00:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Pull request: scottwood/linux.git next
In-Reply-To: <1487329688.2944.0.camel@buserror.net>
References: <20170127235348.GA21260@home.buserror.net>
 <1487329688.2944.0.camel@buserror.net>
Date: Sat, 18 Feb 2017 19:00:32 +1100
Message-ID: <87fujchqsf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <oss@buserror.net> writes:

> On Fri, 2017-01-27 at 17:53 -0600, Scott Wood wrote:
>> Highlights include 8xx breakpoints and perf, t1042rdb display support,
>> and board updates.
>>=20
>> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382ed=
f77:
>>=20
>> =C2=A0 Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
>>=20
>> are available in the git repository at:
>>=20
>> =C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git=
 next
>>=20
>> for you to fetch changes up to 75b824727680a9d12c34d78096a5ac642e53f5d0:
>>=20
>> =C2=A0 powerpc/8xx: Perf events on PPC 8xx (2017-01-26 17:49:34 -0600)
>>=20
>> ----------------------------------------------------------------
>> Christophe Leroy (4):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0powerpc/32: Enable HW_BREAKPOINT on =
BOOK3S
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0powerpc/8xx: Implement hw_breakpoint
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0powerpc/32: Remove FIX_SRR1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0powerpc/8xx: Perf events on PPC 8xx
>>=20
>> Jason Jin (1):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0powerpc/85xx: Enable display support=
 for t1042rdb
>>=20
>> Valentin Longchamp (3):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0powerpc/corenet: explicitly disable =
the SDHC controller on kmcoge4
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0powerpc/85xx: remove the kmp204x_def=
config
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0powerpc/corenet: add support for the=
 kmcent2 board
>
> ping?

Yeah sorry, I've been very behind after being on leave.

I did see this and will pull it.

cheers
