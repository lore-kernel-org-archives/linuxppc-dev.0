Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0bN5Vs9zF1x0
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:04:16 +1100 (AEDT)
In-Reply-To: <20180330115724.23826-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/kvm: Fix guest boot issue DAWR cpu feature
Message-Id: <40D0bN1Wyyz9s3G@ozlabs.org>
Date: Sun,  1 Apr 2018 01:04:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-30 at 11:57:24 UTC, "Aneesh Kumar K.V" wrote:
> SLOF check the 'sc 1' support by issuing a hcall with H_SET_DABR. With
> recent patch to make the hcall return H_UNSUPPORTED, we get guest boot
> failures. SLOF can work with the hcall failure H_HARDWARE for the above
> hcall. Switch the return value to H_HARDWARE instead of H_UNSUPPORTED so that
> we don't break the guest boot.
> 
> Fixes: e8ebedbf ("KVM: PPC: Book3S HV: Return error from h_set_dabr() on POWER9")
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ca9a16c3bc1582da62ef9c47fc2200

cheers
