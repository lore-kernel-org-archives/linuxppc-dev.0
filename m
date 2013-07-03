Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 2755E2C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 07:42:45 +1000 (EST)
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Add LRAT error exception handler
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372882590.8183.149@snotra>
Date: Wed, 3 Jul 2013 23:42:40 +0200
Message-Id: <6D66E322-D680-4F47-9841-E0A299F45EC1@suse.de>
References: <1372870566-11299-1-git-send-email-mihai.caraman@freescale.com>
 <1372870566-11299-2-git-send-email-mihai.caraman@freescale.com>
 <1372882590.8183.149@snotra>
To: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.07.2013, at 22:16, Scott Wood wrote:

> On 07/03/2013 11:56:06 AM, Mihai Caraman wrote:
>> With LRAT (Logical to Real Address Translation) error exception =
handler in kernel
>> KVM needs to add the counterpart otherwise will break the build.
>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>> ---
>> arch/powerpc/kvm/bookehv_interrupts.S |    2 ++
>> 1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> Please combine these two patches to avoid breaking bisectability.

Why does the split break bisectability?


Alex
