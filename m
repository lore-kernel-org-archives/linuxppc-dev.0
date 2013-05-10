Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 400AF2C00D8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2013 05:39:58 +1000 (EST)
References: <1368213757.19683.10@snotra>
Mime-Version: 1.0 (1.0)
In-Reply-To: <1368213757.19683.10@snotra>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <F3847E9E-D4F6-4727-B3A6-42C68797F5CF@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI exception to Guest
Date: Fri, 10 May 2013 21:39:50 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Wood Scott-B07421 <B07421@freescale.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Am 10.05.2013 um 21:22 schrieb Scott Wood <scottwood@freescale.com>:

> On 05/10/2013 12:57:33 PM, Alexander Graf wrote:
>> Could you guys please collect performance data during the next weeks on b=
oth guest-directed ISIs as well as VF MMIOs (preferably with in-kernel MMIO)=
, so that we can decide on the direction that's worth going towards?
>=20
> Collecting data on VF MMIO would require implementing it (or at least salv=
aging and fixing some old code), which is not a high priority at the moment.=
  If we do implement VF in the future we could always undo the direct ISI ch=
ange, but it would still be nice to know if there's any real benefit in the f=
irst place.

Mike sounded like he had an almost working poc, which is good enough to coll=
ect rough numbers.

And yes, changes like these should always get at least basic performance num=
bers along with them, regardless of drawbacks.


Alex

>=20
> FWIW, I doubt that the "more stress on HW TLB" will be significant.
>=20
> -Scott
