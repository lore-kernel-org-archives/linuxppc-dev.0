Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3E4672C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Dec 2012 00:59:10 +1100 (EST)
Subject: Re: [PATCH 10/12] KVM: PPC: bookehv: Add EPCR support in mtspr/mfspr
 emulation
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1349972009-23027-11-git-send-email-mihai.caraman@freescale.com>
Date: Sat, 1 Dec 2012 14:59:03 +0100
Message-Id: <0BB19016-F679-481A-836C-41F717F2CE7A@suse.de>
References: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
 <1349972009-23027-11-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.10.2012, at 18:13, Mihai Caraman wrote:

> Add EPCR support in booke mtspr/mfspr emulation. EPCR register is =
defined only
> for 64-bit and HV categories, we will expose it at this point only to =
64-bit
> virtual processors running on 64-bit HV hosts.
> Define a reusable setter function for vcpu's EPCR.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> v1: extended guard defines with CONFIG_KVM_BOOKE_HV required by arch's =
epcr and
> shadow_epcr fields.

I removed that constraint in another patch I just sent out and will =
remove the guards on HV while applying the patch.


Alex
