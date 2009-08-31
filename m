Return-Path: <michal.simek@petalogix.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E885FB70C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 23:18:58 +1000 (EST)
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 4209CDDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 23:18:56 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b6so1601971ana.39
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 06:18:54 -0700 (PDT)
Message-ID: <4A9BCDB4.8040406@petalogix.com>
Date: Mon, 31 Aug 2009 15:18:44 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] [V3] net: add Xilinx emac lite device driver
References: <20090820094956.02DFC45004F@mail96-dub.bigfish.com>
	<20090820.025226.26907868.davem@davemloft.net>
In-Reply-To: <20090820.025226.26907868.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sadanan@xilinx.com, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	jgarzik@pobox.com, john.linn@xilinx.com, john.williams@petalogix.com
Reply-To: michal.simek@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,

I see that John's patch has wrong file permission
-rwxr-xr-x 	xilinx_emaclite.c
<http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=blob;f=drivers/net/xilinx_emaclite.c;h=7e05b40ae36b50b6eb66d9512ae3a49ba2d36a47;hb=a9a8cb1d6594037fbb23f1ce45964ec6a3b38215>
	blob
<http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=blob;f=drivers/net/xilinx_emaclite.c;h=7e05b40ae36b50b6eb66d9512ae3a49ba2d36a47;hb=a9a8cb1d6594037fbb23f1ce45964ec6a3b38215>
| history
<http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=history;f=drivers/net/xilinx_emaclite.c;h=7e05b40ae36b50b6eb66d9512ae3a49ba2d36a47;hb=a9a8cb1d6594037fbb23f1ce45964ec6a3b38215>
| raw
<http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=blob_plain;f=drivers/net/xilinx_emaclite.c;hb=a9a8cb1d6594037fbb23f1ce45964ec6a3b38215>



should be 644.

Please fix it in your repo.

Thanks,
Michal

> From: John Linn <john.linn@xilinx.com>
> Date: Thu, 20 Aug 2009 03:49:51 -0600
>
>   
>> This patch adds support for the Xilinx Ethernet Lite device.  The
>> soft logic core from Xilinx is typically used on Virtex and Spartan
>> designs attached to either a PowerPC or a Microblaze processor.
>>
>> Signed-off-by: Sadanand M <sadanan@xilinx.com>
>> Signed-off-by: John Linn <john.linn@xilinx.com>
>>     
>
> Applied, thanks.
>   


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
