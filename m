Return-Path: <r61911@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 475952C0092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 19:34:48 +1000 (EST)
Message-ID: <5176C602.9050507@freescale.com>
Date: Wed, 24 Apr 2013 01:33:54 +0800
From: Roy Zang <tie-fei.zang@freescale.com>
MIME-Version: 1.0
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH v2] powerpc/fsl-pci:fix incorrect iounmap pci
 hose->private_data
References: <1366730283-14606-1-git-send-email-tie-fei.zang@freescale.com>
 <20130423091327.GA23644@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20130423091327.GA23644@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Yuanquan Chen <Yuanquan.Chen@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/23/2013 05:13 PM, Kevin Hao wrote:
> On Tue, Apr 23, 2013 at 11:18:03PM +0800, Roy Zang wrote:
>> pci hose->private_data will be used by other function, for example,
>> fsl_pcie_check_link(), so do not iounmap it.
> I already sent out a same patch ten days ago. :-)
>
> http://patchwork.ozlabs.org/patch/236293/
>
> Thanks,
> Kevin
>
I do not notice it. That is good :-)
Kumar,
You can pick up the post from Kevin.
Thanks.
Roy
