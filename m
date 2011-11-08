Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (mail-va3.bigfish.com [216.32.180.10])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7F101B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 04:31:39 +1100 (EST)
Received: from mail18-va3 (localhost [127.0.0.1])	by mail18-va3-R.bigfish.com
 (Postfix) with ESMTP id 706D66001FF	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Nov 2011 17:31:29 +0000 (UTC)
Received: from VA3EHSMHS028.bigfish.com (unknown [10.7.14.252])	by
 mail18-va3.bigfish.com (Postfix) with ESMTP id 2B243360051	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 17:31:29 +0000 (UTC)
Message-ID: <4EB9676F.4080509@freescale.com>
Date: Tue, 8 Nov 2011 11:31:27 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH 3/7] powerpc/85xx: add sleep and deep sleep support
References: <1320410014-14453-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB432C1.1000601@freescale.com>
 <3F607A5180246847A760FD34122A1E052BC91C@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <3F607A5180246847A760FD34122A1E052BC91C@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="windows-1252"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/08/2011 04:32 AM, Li Yang-R58472 wrote:
>> Subject: Re: [PATCH 3/7] powerpc/85xx: add sleep and deep sleep support
>>
>> On 11/04/2011 07:33 AM, Zhao Chenhui wrote:
>>>  static int pmc_suspend_enter(suspend_state_t state)
>>>  {
>>>  	int ret;
>>> +	u32 powmgtreq = 0x00500000;
>>
>> Where does this 0x00500000 come from?  Please symbolically define
>> individual bits.
>>
>> The comment in the asm code says it should be 0x00100000, BTW.
> 
> I think we should get rid of the powmgtreq argument, as we don't support multiple modes for mpc85xx_enter_deep_sleep() now.

Doesn't that happen later in the patch series?

-Scott
