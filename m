Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 08E13B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2012 06:19:11 +1100 (EST)
Received: from mail108-ch1 (localhost [127.0.0.1])	by
 mail108-ch1-R.bigfish.com (Postfix) with ESMTP id 552D76C0214	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2012 19:19:06 +0000 (UTC)
Received: from CH1EHSMHS014.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.253])	by mail108-ch1.bigfish.com (Postfix) with ESMTP id
 2CEEA200066	for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2012 19:19:06
 +0000 (UTC)
Message-ID: <4F04A627.7060803@freescale.com>
Date: Wed, 4 Jan 2012 13:19:03 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Huang Changming-R66093 <r66093@freescale.com>
Subject: Re: [PATCH] DTS: fix the bug and add the chip compatible for eSDHC
References: <1324620659-7135-1-git-send-email-r66093@freescale.com>
 <CAOZdJXXXvTuJO_ZpyeRatWxTMbmcEVokA9qx7ajNdzKyiEgBhw@mail.gmail.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F1165E585@039-SN1MPN1-005.039d.mgd.msft.net>
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F1165E585@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Tabi Timur-B04825 <B04825@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/03/2012 09:14 PM, Huang Changming-R66093 wrote:
> 
> 
>> -----Original Message-----
>> From: Tabi Timur-B04825
>> Sent: Tuesday, January 03, 2012 4:30 AM
>> To: Huang Changming-R66093
>> Cc: linuxppc-dev@lists.ozlabs.org; Huang Changming-R66093
>> Subject: Re: [PATCH] DTS: fix the bug and add the chip compatible for
>> eSDHC
>>
>> On Fri, Dec 23, 2011 at 12:10 AM,  <r66093@freescale.com> wrote:
>>>
>>> Accordint to latest kernel, the auto-cmd12 property should be
>>> "sdhci,auto-cmd12", and according to the SDHC binding and the
>>> workaround for the special chip, add the chip compatible for eSDHC:
>>> "fsl,p1022-esdhc", "fsl,mpc8536-esdhc", "fsl,p2020-esdhc" and
>> "fsl,p1010-esdhc".
>>
>> Please do not use the phrase "fix the bug" in patch summaries.
>>
> Then, could you tell me how to describe it?

The subject line should be something like:

  powerpc/fsl: esdhc node fixes

Phrases like "Fix the bug" or "fix the issue" could apply to lots of
patches and don't really add anything, especially in the subject line
where there isn't much space and you want to clearly and concisely
identify what this patch is about.

-Scott
