Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8FE0DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 15:57:35 +1100 (EST)
Date: Fri, 14 Nov 2008 07:57:27 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1124454405.20081114075727@emcraft.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re[2]: [PATCH] xsysace: use resource_size_t instead of unsigned long
In-Reply-To: <20081113212121.e7a9f5fe.sfr@canb.auug.org.au>
References: <200811131143.17752.yur@emcraft.com>
	<20081113212121.e7a9f5fe.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	linux-kernel@vger.kernel.org, Ilya Yanok <yanok@emcraft.com>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0AHello Stephen,

On Thursday, November 13, 2008 you wrote:

> Hi Yuri,

> On Thu, 13 Nov 2008 11:43:17 +0300 Yuri Tikhonov <yur@emcraft.com> wrote:
>>
>> -     dev_dbg(ace->dev, "physaddr=3D0x%lx irq=3D%i\n", ace->physaddr, ac=
e->irq);
>> +     dev_dbg(ace->dev, "physaddr=3D0x%llx irq=3D%i\n", (u64)ace->physad=
dr, ace->irq);

> You should cast the physaddr to "unsigned long long" as "u64" is
> "unsigned long" on some architectures.  The same is needed in other
> places as well.

 Thanks for your comment. We'll fix this.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
