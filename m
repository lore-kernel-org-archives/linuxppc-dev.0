Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zg2wN0GtKzF0ks
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 22:08:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org <kvm-ppc@vger.kernel.org>
Subject: Re: KVM compile error
In-Reply-To: <064C3590-DCF8-4764-B0A4-B49310F1AF89@xenosoft.de>
References: <064C3590-DCF8-4764-B0A4-B49310F1AF89@xenosoft.de>
Date: Mon, 12 Feb 2018 22:08:27 +1100
Message-ID: <874lmmwjmc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Zigotzky <chzigotzky@xenosoft.de> writes:

> Just for info: KVM doesn=E2=80=99t compile currently.
>
> Error messages:
>
> CC      arch/powerpc/kvm/powerpc.o
> arch/powerpc/kvm/powerpc.c: In function 'kvm_arch_vcpu_ioctl_run':
> arch/powerpc/kvm/powerpc.c:1611:1: error: label 'out' defined but not use=
d [-Werror=3Dunused-label]
>  out:
>  ^
> cc1: all warnings being treated as errors

I don't see this, which compiler/config/commit is that?

cheers
