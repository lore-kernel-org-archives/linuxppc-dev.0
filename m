Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk3Rn2tBSzDqCt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 21:41:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, kbuild test robot <lkp@intel.com>,
 Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] include/linux/vfio.h: Guard powerpc-specific functions
 with CONFIG_VFIO_SPAPR_EEH
In-Reply-To: <a0d62075-cb00-c69b-7f39-95a3b53f4061@ozlabs.ru>
References: <201706080005.vXjRK5G3%fengguang.wu@intel.com>
 <a0d62075-cb00-c69b-7f39-95a3b53f4061@ozlabs.ru>
Date: Thu, 08 Jun 2017 21:41:53 +1000
Message-ID: <871squemf2.fsf@concordia.ellerman.id.au>
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

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> Hi,
>
> How did you manage to have CONFIG_EEH=y and CONFIG_VFIO_SPAPR_EEH=n? "make
> oldconfig" fixes this to CONFIG_VFIO_SPAPR_EEH=y.

Hmm, Murilo did you confirm the bug still happens on upstream with that
rand config?

cheers
