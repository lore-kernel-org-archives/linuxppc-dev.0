Return-Path: <Emilian.Medve@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C35492C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 12:57:33 +1100 (EST)
Message-ID: <5282DBC2.5090609@Freescale.com>
Date: Tue, 12 Nov 2013 19:54:10 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] phylib: Add Clause 45 read/write functions
References: <1384167864-2457-1-git-send-email-shh.xie@gmail.com>
 <1384293487.1403.67.camel@snotra.buserror.net>
 <ED492CCEAF882048BC2237DE806547C91512489F@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <ED492CCEAF882048BC2237DE806547C91512489F@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Xiao-Hui,


On 11/12/2013 07:51 PM, Shaohui Xie wrote:
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Wednesday, November 13, 2013 5:58 AM
>> To: shh.xie@gmail.com
>> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Kanetkar
>> Shruti-B44454; Xie Shaohui-B21989; Bucur Madalin-Cristian-B32716
>> Subject: Re: [PATCH 1/4] phylib: Add Clause 45 read/write functions
>>
>> On Mon, 2013-11-11 at 19:04 +0800, shh.xie@gmail.com wrote:
>>> From: Andy Fleming
>>>
>>> You need an extra parameter to read or write Clause 45 PHYs, so we
>>> need a different API with the extra parameter.
>>>
>>> Signed-off-by: Andy Fleming
>>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>>
>> Why did you remove Andy's e-mail address?  Even though it's no longer valid, it
>> helps identify which specific person you're talking about.
>>
> [S.H] Andy's e-mail address is not valid and git-send-mail will fail, I have to remove it to make git work.

Just use Andy's GMail address: afleming@gmail.com


Cheers,
