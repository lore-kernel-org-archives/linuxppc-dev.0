Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 374BB474C4
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 08:51:53 +1100 (EST)
Date: Tue, 13 Jan 2009 00:52:08 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1473903899.20090113005208@emcraft.com>
To: "prodyut hazarika" <prodyuth@gmail.com>
Subject: Re[2]: [PATCH][v3] powerpc 44x: support for 256KB PAGE_SIZE
In-Reply-To: <49c0ff980901121102t46b1e50cna6fbd333142485b7@mail.gmail.com>
References: <200901112142.31003.yur@emcraft.com>
	<49c0ff980901121102t46b1e50cna6fbd333142485b7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: wd@denx.de, yanok@emcraft.com, miltonm@bga.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org, hugh@veritas.com, akpm@linux-foundation.org, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0AHello Prodyut,

On Monday, January 12, 2009 you wrote:

> On Sun, Jan 11, 2009 at 10:42 AM, Yuri Tikhonov <yur@emcraft.com> wrote:
>>
>> This patch adds support for 256KB pages on ppc44x-based boards.
>>

> Hi Yuri,
> Do you still need the mm/shmem.c patch to avoid division by zero?

 Yes.

> I looked at the mm/shmem.c latest git code, and I see that it doesn't
> have the needed patch for 256KB page.

 Right. We proposed the work-around for this (which just simply=20
increased the sizes of variables which hold the overflowed values) to=20
LKML here:

http://lkml.org/lkml/2008/12/19/20

 If I understand Hugh right, then such a fix is acceptable, but much=20
far from the best, so Hugh is about to implement the correct fix for=20
the problem as soon as he'll find some time (big thanks to him for=20
this).

> I think another option would be to make 256KB compile only if CONFIG_SHME=
M=3Dn

 Agree. For the current situation it seems the better solution. I'll=20
update, and re-post the patch shortly.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
