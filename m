Return-Path: <B08782@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 28DDC2C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 22:52:10 +1100 (EST)
Message-ID: <527395DF.50104@freescale.com>
Date: Fri, 1 Nov 2013 13:51:59 +0200
From: Claudiu Manoil <claudiu.manoil@freescale.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Thomas_H=FChn?= <thomas@net.t-labs.tu-berlin.de>
Subject: Re: Gianfar driver crashes in Kernel v3.10
References: <90BE8C5D-E23B-41B5-BB52-8A0C0758931D@net.t-labs.tu-berlin.de>
 <760FFC38-597B-46CB-BA4C-620A1D663C8A@net.t-labs.tu-berlin.de>
 <525E3BD7.1020208@freescale.com>
 <05E1EDFE-EDFB-4E6F-AA83-D353B4032CA5@net.t-labs.tu-berlin.de>
In-Reply-To: <05E1EDFE-EDFB-4E6F-AA83-D353B4032CA5@net.t-labs.tu-berlin.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Thomas,

On 10/31/2013 1:51 PM, Thomas H=FChn wrote:
> Hi Claudiu,
>
>
>> Please try the following patch:
>> http://patchwork.ozlabs.org/patch/283235/
>>
>> It should help with your issue.
>>
>
> Several OpenWrt users including myself have tested your patch on
> TPLink-4900 routers.
> We do have positive feedback, as no crash nor system freeze was reporte=
d
> for different
> network loads and router setups.
> All different scenarios / details and two digit uptimes are in this
> forum thread:
> https://forum.openwrt.org/viewtopic.php?id=3D42062&p=3D13
>
> Thanks again for your work and  I hope to see this patch merged upstrea=
m.
>
> Greetings Thomas
>

Thanks for the testing and feedback.

The patch has been merged into davem/net-next.git:

http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=
=3D3ba405db1c1b05d157474c71e559393f7ea436ad

And I think it will be merged from there into the next
kernel release. I think that in time it will be back-ported
to stable kernel versions too. In some cases, requests are made
to the netdev mailing list to speedup inclusion of fixes (such
as this one) to certain stable kernel versions.

Thanks,
Claudiu
