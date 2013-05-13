Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 515E12C0099
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 12:04:38 +1000 (EST)
Message-ID: <51904A30.8010408@windriver.com>
Date: Mon, 13 May 2013 10:04:32 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>, Caraman Mihai Claudiu-B02008
 <B02008@freescale.com>
Subject: Re: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI exception to Guest
References: <1368213757.19683.10@snotra>
 <F3847E9E-D4F6-4727-B3A6-42C68797F5CF@suse.de>
In-Reply-To: <F3847E9E-D4F6-4727-B3A6-42C68797F5CF@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/11/2013 03:39 AM, Alexander Graf wrote:
>
>
> Am 10.05.2013 um 21:22 schrieb Scott Wood <scottwood@freescale.com>:
>
>> On 05/10/2013 12:57:33 PM, Alexander Graf wrote:
>>> Could you guys please collect performance data during the next weeks on both guest-directed ISIs as well as VF MMIOs (preferably with in-kernel MMIO), so that we can decide on the direction that's worth going towards?
>>
>> Collecting data on VF MMIO would require implementing it (or at least salvaging and fixing some old code), which is not a high priority at the moment.  If we do implement VF in the future we could always undo the direct ISI change, but it would still be nice to know if there's any real benefit in the first place.
>
> Mike sounded like he had an almost working poc, which is good enough to collect rough numbers.

Which can the test case be adopted?

Mike,

If you already have a good case for your poc, please share that with me. Then 
I'd like to run that.

Tiejun

>
> And yes, changes like these should always get at least basic performance numbers along with them, regardless of drawbacks.
>
>
> Alex
>
>>
>> FWIW, I doubt that the "more stress on HW TLB" will be significant.
>>
>> -Scott
>
