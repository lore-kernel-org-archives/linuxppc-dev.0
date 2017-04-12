Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w32G75G67zDqFV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:47:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: christophe lombard <clombard@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH V4 7/7] cxl: Add psl9 specific code
In-Reply-To: <55ea010d-fc0b-9f8b-35f5-37cdc5d4792f@linux.vnet.ibm.com>
References: <1491574319-11852-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1491574319-11852-8-git-send-email-clombard@linux.vnet.ibm.com>
 <2584b575-bc19-d7d8-3017-7c462a5fa800@linux.vnet.ibm.com>
 <87bms2v0h2.fsf@concordia.ellerman.id.au>
 <55ea010d-fc0b-9f8b-35f5-37cdc5d4792f@linux.vnet.ibm.com>
Date: Wed, 12 Apr 2017 21:47:10 +1000
Message-ID: <87tw5t6e69.fsf@concordia.ellerman.id.au>
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

christophe lombard <clombard@linux.vnet.ibm.com> writes:
> Le 12/04/2017 =C3=A0 04:11, Michael Ellerman a =C3=A9crit :
> Hi,
>
> Here is a new patch which updates the documentation based
> on the complet PATCH V4 7/7.
> Let me know if it suits you.

Fine by me, I'll wait for Fred's ack before I merge it all.

> Index: capi2_linux_prepare_patch_V4/Documentation/powerpc/cxl.txt
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- capi2_linux_prepare_patch_V4.orig/Documentation/powerpc/cxl.txt
> +++ capi2_linux_prepare_patch_V4/Documentation/powerpc/cxl.txt
> @@ -62,6 +62,7 @@ Hardware overview
>       POWER8 <-----> PSL Version 8 is compliant to the CAIA Version 1.0.
>       POWER9 <-----> PSL Version 9 is compliant to the CAIA Version 2.0.
>       This PSL Version 9 provides new features as:
> +    * Interaction with the nest MMU which resides within each P9 chip.
>       * Native DMA support.
>       * Supports sending ASB_Notify messages for host thread wakeup.
>       * Supports Atomic operations.

The path didn't actually apply, the whitespace is messed up, but I fixed
it up.

cheers
