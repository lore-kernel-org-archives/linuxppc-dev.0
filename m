Return-Path: <Ravinder.Kumar@Sun.COM>
Received: from sca-es-mail-1.sun.com (sca-es-mail-1.Sun.COM [192.18.43.132])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9620CB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 17:05:49 +1000 (EST)
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id
	n816k8gA004203 for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 23:46:20 -0700 (PDT)
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII; delsp=yes; format=flowed
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
	(Sun Java(tm) System Messaging Server 7u2-7.04 64bit (built Jul 2
	2009)) id <0KPA00J005DXPR00@fe-sfbay-09.sun.com> for
	linuxppc-dev@lists.ozlabs.org; Mon, 31 Aug 2009 23:46:08 -0700 (PDT)
Date: Mon, 31 Aug 2009 23:46:07 -0700
From: Ravinder Kumar <Ravinder.Kumar@Sun.COM>
Subject: Re: ECC & Magic bitmask errors with JFFS2 file system on 6.23 kernel
	for	powerpc
In-reply-to: <20090831234713.GA6767@oksana.dev.rtsoft.ru>
Sender: Ravinder.Kumar@Sun.COM
To: avorontsov@ru.mvista.com
Message-id: <F805585C-5DEE-4F99-B448-C231C49BEDEB@Sun.COM>
References: <OF4DA6695F.B8912DE2-ON652575F5.004F0DE0-652575F5.00519736@lntemsys.com>
	<4A9C34EE.4040606@Sun.COM> <20090831234713.GA6767@oksana.dev.rtsoft.ru>
Cc: louise <louise@Sun.COM>, Rupesh Kumar <Rupesh.Kumar@Lntemsys.com>,
	linuxppc-dev@lists.ozlabs.org, Louise.Yeung@Sun.COM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Aug 31, 2009, at 4:47 PM, Anton Vorontsov wrote:

> On Mon, Aug 31, 2009 at 01:39:10PM -0700, Louise.Yeung@Sun.COM wrote:
>> *Hi Rupesh,
>>
>> We are using a Freescale processor similar to yours with NAND flash
>> supporting 2KB page size .
>
> What kernel version and NAND driver you use? I don't think that old
> BSP kernels include fsl_elbc_nand driver, which is a much improved
> version of the fsl_fcm driver.

We are using 2.6.23 kernel with freescale patches. The sources have  
fsl_elbc driver.
I think the newer BSP kernels have fsl_elbc_nand driver. Will look at  
it.

Thanks
Ravinder

>
> So you might want to swith to a newer kernel or back-port the
> fsl_elbc_nand driver[1] and a few fixes to your kernel.
>
> [1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=drivers/mtd/nand/fsl_elbc_nand.c
>
> -- 
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
