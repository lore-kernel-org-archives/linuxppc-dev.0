Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
 [216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4C03DB6FC9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 04:45:29 +1100 (EST)
Received: from mail52-va3 (localhost [127.0.0.1])	by mail52-va3-R.bigfish.com
 (Postfix) with ESMTP id E673120075	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 10 Jan 2012 17:45:20 +0000 (UTC)
Received: from VA3EHSMHS001.bigfish.com (unknown [10.7.14.239])	by
 mail52-va3.bigfish.com (Postfix) with ESMTP id 2FD8F24004D	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 17:45:19 +0000 (UTC)
Message-ID: <4F0C7928.1020803@freescale.com>
Date: Tue, 10 Jan 2012 11:45:12 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Tang Yuantian-B29983 <B29983@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: Add P1024rdb dts support
References: <1326098258-32097-1-git-send-email-b29983@freescale.com>
 <4F0B561A.7060903@freescale.com>
 <D07C73A334FF604B95B3CBD2A545D07B02444B@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B02444B@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/2012 09:45 PM, Tang Yuantian-B29983 wrote:
> 
>> On 01/09/2012 02:37 AM, b29983@freescale.com wrote:
>>> +/include/ "p1024rdb.dtsi"
>>> +/include/ "fsl/p1020si-post.dtsi"
>>
>> Is p1024 100% software-compatible with p1020?
>>
>> They have different manuals...
>>
>> -Scott
> 
> P1020rdb has vitesse-7385 switch.

I'm talking about the SoC, not the board.

> fsl/p1020si-post.dtsi can be used for both boards.

What are you basing this on?  Has someone looked over both manuals in
detail and concluded that every device described is 100% compatible?

-Scott
