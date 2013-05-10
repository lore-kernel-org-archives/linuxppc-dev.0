Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 0FDCE2C00DF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2013 03:57:39 +1000 (EST)
Subject: Re: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI exception to Guest
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF3F80D6@039-SN2MPN1-012.039d.mgd.msft.net>
Date: Fri, 10 May 2013 19:57:33 +0200
Message-Id: <F4F07A17-8E1E-433D-9749-68D1495C42A7@suse.de>
References: <1367970043.3398.39@snotra> <5189B02E.3000109@windriver.com>
 <300B73AA675FCE4A93EB4FC1D42459FF3EFA26@039-SN2MPN1-013.039d.mgd.msft.net>
 <518A1AD8.3090103@windriver.com> <518B7913.6010302@windriver.com>
 <300B73AA675FCE4A93EB4FC1D42459FF3F7FBE@039-SN2MPN1-012.039d.mgd.msft.net>
 <518B8B2A.1020103@windriver.com>
 <300B73AA675FCE4A93EB4FC1D42459FF3F80D6@039-SN2MPN1-012.039d.mgd.msft.net>
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Cc: "tiejun.chen" <tiejun.chen@windriver.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 09.05.2013, at 14:36, Caraman Mihai Claudiu-B02008 wrote:

>> -----Original Message-----
>> From: tiejun.chen [mailto:tiejun.chen@windriver.com]
>> Sent: Thursday, May 09, 2013 2:40 PM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; agraf@suse.de; =
kvm-
>> ppc@vger.kernel.org; kvm@vger.kernel.org
>> Subject: Re: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI =
exception to
>> Guest
>>=20
>> On 05/09/2013 07:34 PM, Caraman Mihai Claudiu-B02008 wrote:
>>>>>> VF stands for virtualization fault see MAS8[VF] and we may use it
>> for
>>>> virtualized
>>>>=20
>>>> Looks KVM PPC have no this mechanism currently since I don't find
>> MAS8_VF
>>>> is
>>>> used in kernel, right?
>>>=20
>>> Yes but 'we may use it' in the feature, I have a functional POC with
>> VF.
>>=20
>> Any IO performance to be improved with this POC?
>=20
> VF approach puts more stress on HW TLB so I did not advance with =
performance
> measurements though it may worth to do it.

Could you guys please collect performance data during the next weeks on =
both guest-directed ISIs as well as VF MMIOs (preferably with in-kernel =
MMIO), so that we can decide on the direction that's worth going =
towards?


Thanks!

Alex
