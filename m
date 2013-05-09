Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6625A2C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 21:40:35 +1000 (EST)
Message-ID: <518B8B2A.1020103@windriver.com>
Date: Thu, 9 May 2013 19:40:26 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Subject: Re: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI exception to Guest
References: <1367970043.3398.39@snotra> <5189B02E.3000109@windriver.com>
 <300B73AA675FCE4A93EB4FC1D42459FF3EFA26@039-SN2MPN1-013.039d.mgd.msft.net>
 <518A1AD8.3090103@windriver.com> <518B7913.6010302@windriver.com>
 <300B73AA675FCE4A93EB4FC1D42459FF3F7FBE@039-SN2MPN1-012.039d.mgd.msft.net>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF3F7FBE@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/09/2013 07:34 PM, Caraman Mihai Claudiu-B02008 wrote:
>>>> VF stands for virtualization fault see MAS8[VF] and we may use it for
>> virtualized
>>
>> Looks KVM PPC have no this mechanism currently since I don't find MAS8_VF
>> is
>> used in kernel, right?
>
> Yes but 'we may use it' in the feature, I have a functional POC with VF.

Any IO performance to be improved with this POC?

> Now we capture virtualized MMIO accesses as TLB misses (we don't write
> into HW TLB guest translation outside visible memslots).

Yes.

Tiejun
