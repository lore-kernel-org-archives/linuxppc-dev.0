Return-Path: <Bo.Liu@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 8AC0CB708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 07:55:15 +1000 (EST)
Message-ID: <4A5FDCDF.9010005@windriver.com>
Date: Fri, 17 Jul 2009 10:07:27 +0800
From: tonyliu <Bo.Liu@windriver.com>
MIME-Version: 1.0
To: Rupesh Kumar <Rupesh.Kumar@Lntemsys.com>
Subject: Re: booting MPC8313 based board with yaffs2 RFS
References: <OFB2EFC395.7BD1B8AD-ON652575F4.00512780-652575F4.00513235@lntemsys.com>
In-Reply-To: <OFB2EFC395.7BD1B8AD-ON652575F4.00512780-652575F4.00513235@lntemsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Rupesh Kumar wrote:
> Hi
> I am using MPC8313 board which is currently booting with JFFS2 root file 
> system. 
> I am using linux kernel version 2.6.23 from FreeScale's LTIB for MPC8313. 
>
> As, I want it to boot with YAFFS2 root file system, I did compile kernel 
> with yaffs2 support, craeted yaffs2 rootfile system and passed yaffs2 
> partiton of nand in bootargs. However it didnot work.
>
>
> If any one has done it successfully, can please share the steps to be 
> followed ?
>   
More detailed info maybe helpful for debugging this issue.

1. What nand flash is on-board? what's the size of the nand flash page 
size, 512/2048?
2. what's the version of mkyaffs2image you are using?
3. Can you mount an empty nand flash partition using yaffs2 type,
mount  /dev/mtdblock##x   xxx
4. It's better to attatch bootup message.

Tony
> Thanks
> Rupesh
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>   
