Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qNybv1sgxzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 00:03:23 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id n205so14941656wmf.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2016 06:03:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH 0/7] KVM/X86/PPC: Clear up kvm mmu memory barriers and
 update related comments
To: Lan Tianyu <tianyu.lan@intel.com>, guangrong.xiao@linux.intel.com,
 agraf@suse.com, benh@kernel.crashing.org, gleb@kernel.org, hpa@zytor.com,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mingo@redhat.com, mpe@ellerman.id.au,
 paulus@samba.org, tglx@linutronix.de, x86@kernel.org
References: <1457838631-26775-1-git-send-email-tianyu.lan@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56E6B690.70208@redhat.com>
Date: Mon, 14 Mar 2016 14:03:12 +0100
MIME-Version: 1.0
In-Reply-To: <1457838631-26775-1-git-send-email-tianyu.lan@intel.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 13/03/2016 04:10, Lan Tianyu wrote:
> This series is to clear up kvm mmu memory barriers.
> 1) Remove redundant barrier (PATCH 1)
> 2) Replace origin barrier functions with preferrable ones (PATCH 2, 3, 5)
> 3) Fix unpaired barriers (PATCH 4)
> 4) Update or add barrier related comments (PATCH 6, 7)

Thanks, this looks pretty good!  I will apply it for 4.6 if I have to
send two pull requests during this merge window; otherwise, it will have
to wait for the next merge window.

Paolo
