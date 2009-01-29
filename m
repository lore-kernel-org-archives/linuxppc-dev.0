Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 375EDDE203
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 22:41:05 +1100 (EST)
Date: Thu, 29 Jan 2009 14:40:33 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <389491948.20090129144033@emcraft.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re[4]: [PATCH][v4] powerpc 44x: support for 256KB PAGE_SIZE
In-Reply-To: <6206e2ad09c4ee677275859dc6d5046e@bga.com>
References: <200901130149.43588.yur@emcraft.com>
	<f341f40f2bfa0818be32a86da62ada9b@bga.com>
	<1336101832.20090116181842@emcraft.com>
	<6206e2ad09c4ee677275859dc6d5046e@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: yanok@emcraft.com, dzu@denx.de, linuxppc-dev@ozlabs.org, hugh@veritas.com,
	paulus@samba.org, akpm@linux-foundation.org, prodyuth@gmail.com, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0AOn Sunday, January 18, 2009 you wrote:
> Ok I tried this out in menuconfig.  You are right that the depends on=20
> makes sense as it removes the option from the config file as not=20
> relevant.  But right now to enable 256K pages one has to go to platform
> setup to find this dependency, then has to go to general setup to find
> the shmem option at the bottom of the list in the embedded/expert=20
> section, then finally go to the kernel options menu to finally choose=20
> the page size.

> Moving this question just before the page size choice removes one of=20
> those hidden menu, so I suggest that it be moved to just before the=20
> option that it allow be selected.

 Right, it'll me more convenient. My [v5] patch addresses this.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
