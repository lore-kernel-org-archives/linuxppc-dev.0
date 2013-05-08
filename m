Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 794C52C010A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2013 11:53:59 +1000 (EST)
Message-ID: <5189B02E.3000109@windriver.com>
Date: Wed, 8 May 2013 09:53:50 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI exception to Guest
References: <1367970043.3398.39@snotra>
In-Reply-To: <1367970043.3398.39@snotra>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/08/2013 07:40 AM, Scott Wood wrote:
> On 05/07/2013 06:06:30 AM, Tiejun Chen wrote:
>> We also can direct ISI exception to Guest like DSI.
>>
>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> ---
>>  arch/powerpc/kvm/booke_emulate.c |    3 +++
>>  arch/powerpc/kvm/e500mc.c        |    3 ++-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> Are you seeing a real performance improvement from this?  This will interfere

No. But after we reduce the exit to host, shouldn't this improve performance?

> somewhat with using the VF bit, if we were to ever do so, since VF only affects

Sorry, what is the VF you said?

Tiejun
