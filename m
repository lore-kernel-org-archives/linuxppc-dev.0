Return-Path: <zyjzyj2000@gmail.com>
Received: from mail-pb0-x22d.google.com (mail-pb0-x22d.google.com
 [IPv6:2607:f8b0:400e:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 52CEE14008B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 21:18:18 +1100 (EST)
Received: by mail-pb0-f45.google.com with SMTP id uo5so1627666pbc.18
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Apr 2014 03:18:14 -0700 (PDT)
Message-ID: <533D355C.6050501@gmail.com>
Date: Thu, 03 Apr 2014 18:18:04 +0800
From: zhuyj <zyjzyj2000@gmail.com>
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
Subject: Re: on kernel 2.6.34.15, vlan and raw packets can not be received
 with gfar-enet nic
References: <53310F4E.4080104@gmail.com> <533D25D4.4000607@gmail.com>
 <20140403092727.GD16158@1wt.eu> <533D30A1.1060509@gmail.com>
 <20140403100128.GE16158@1wt.eu>
In-Reply-To: <20140403100128.GE16158@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Yang, Zhangle \(Eric\)" <Zhangle.Yang@windriver.com>,
 netdev@vger.kernel.org, richardcochran@gmail.com,
 linuxppc-dev@lists.ozlabs.org, guang.yang@windriver.com,
 linux-kernel@vger.kernel.org, yongjun_wei@trendmicro.com.cn,
 zhuyj <zyjzyj2000@gmail.com>, sandeep.kumar@freescale.com,
 Claudiu Manoil <claudiu.manoil@freescale.com>, "Tao,
 Yue" <Yue.Tao@windriver.com>, joe@perches.com, festevam@gmail.com,
 clarocq@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/03/2014 06:01 PM, Willy Tarreau wrote:
> Hi Zhu,
>
> On Thu, Apr 03, 2014 at 05:57:53PM +0800, zhuyj wrote:
>> I reference the following 2 mainline commits. These 2 commits are based
>> on the current kernel 3.x and ethtool.
>> If we only backport these 2 commits on kernel 2.6.x, this problem will
>> not be fixed yet.
> OK fine, I just wanted that we keep the reference of these equivalent
> patches in the commit message so that if later a newer patch changes
> anything they did, at least we have some indications that the commit
> might also have to be revisited.
>
> I'll merge your patch and put these references there.
>
> Thanks,
> Willy
OK. Thanks a lot.

Zhu Yanjun
> .
>
