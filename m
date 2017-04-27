Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDGLF04vWzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 22:22:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 benh@kernel.crashing.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Native usage of the XIVE
 interrupt controller
In-Reply-To: <20170427101230.GA22113@fergus.ozlabs.ibm.com>
References: <1493172450-19636-1-git-send-email-mpe@ellerman.id.au>
 <20170426121330.GA12057@fergus.ozlabs.ibm.com>
 <20170427101230.GA22113@fergus.ozlabs.ibm.com>
Date: Thu, 27 Apr 2017 22:22:41 +1000
Message-ID: <874lxa11m6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> To get this to compile for all my test configs takes this additional
> patch.  I test-build configs with PR KVM and not HV (both modular and
> built-in) and a config with HV enabled but CONFIG_KVM_XICS=n.  Please
> squash this into your topic branch.

Thanks, squashed and pushed as:

5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")

cheers
