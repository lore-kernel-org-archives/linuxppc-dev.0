Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BB22DDF2A
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 16:49:22 +1100 (EST)
Date: Fri, 19 Dec 2008 08:49:10 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1626525439.20081219084910@emcraft.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re[2]: [PATCH][v2] fork_init: fix division by zero
In-Reply-To: <20081218144553.91226f50.akpm@linux-foundation.org>
References: <200812101950.51958.yur@emcraft.com>
	<20081211121635.ff58193f.akpm@linux-foundation.org>
	<18753.46301.944770.779390@cargo.ozlabs.ibm.com>
	<200812181047.50332.yur@emcraft.com>
	<20081218144553.91226f50.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: wd@denx.de, dzu@denx.de, linux-kernel@vger.kernel.org, miltonm@bga.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	viro@zeniv.linux.org.uk, Hugh Dickins <hugh@veritas.com>,
	Geert.Uytterhoeven@sonycom.com, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0AHello Andrew,

On Friday, December 19, 2008 you wrote:
[snip]
>>  There is one more warning from the common code when I use 256KB pages:
>>=20
>>    CC      mm/shmem.o
>> mm/shmem.c: In function 'shmem_truncate_range':
>> mm/shmem.c:613: warning: division by zero
>> mm/shmem.c:619: warning: division by zero
>> mm/shmem.c:644: warning: division by zero
>> mm/shmem.c: In function 'shmem_unuse_inode':
>> mm/shmem.c:873: warning: division by zero
>>=20
>>  The problem here is that ENTRIES_PER_PAGEPAGE becomes 0x1.0000.0000
>> when PAGE_SIZE is 256K.
>>=20
>>  How about the following fix ?

[snip]

> Looks sane.

 Thanks for reviewing.

> But to apply this I'd prefer a changelog, a signoff and a grunt from Hugh.

 Sure, I'll post this in the separate thread then; keeping Hugh in CC.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
