Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81D59DE760
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 03:56:16 +1000 (EST)
Message-Id: <6C9CC80B-8422-4612-BDFF-22DC245F2179@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080523141541.GA16217@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] mpic: fix ambiguous else statement
Date: Fri, 23 May 2008 12:56:08 -0500
References: <20080523141541.GA16217@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 23, 2008, at 9:15 AM, Anton Vorontsov wrote:

> This patch fixes following warning introduced by
> commit 475ca391b490a683d66bf19999a8a7a24913f139 (mpic: Deal with =20
> bogus NIRQ
> in Feature Reporting Register):
>
>  CC      arch/powerpc/sysdev/mpic.o
> arch/powerpc/sysdev/mpic.c: In function =E2=80=98mpic_alloc=E2=80=99:
> arch/powerpc/sysdev/mpic.c:1146: warning: suggest explicit braces to =20=

> avoid ambiguous =E2=80=98else=E2=80=99
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

as pointed at to me if you set LANG=3DC in your environment gcc will =20
stop spitting out the funny chars.

- k
