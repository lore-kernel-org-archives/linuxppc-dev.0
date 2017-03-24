Return-Path: <srs0=zpq8=3b=au1.ibm.com=michael.neuling@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vq8zc4zBDzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 15:08:28 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vq8zc4JcGz8vrs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 15:08:28 +1100 (AEDT)
Message-ID: <1490328509.28113.55.camel@au1.ibm.com>
Subject: Re: [PATCH v3 03/10] VAS: Define vas_init() and vas_exit()
From: Michael Neuling <michael.neuling@au1.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 apopple@au1.ibm.com,  oohall@gmail.com
Date: Fri, 24 Mar 2017 15:08:29 +1100
In-Reply-To: <1489721642-5657-4-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-4-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-03-16 at 20:33 -0700, Sukadev Bhattiprolu wrote:
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3673,8 +3673,6 @@ F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0a=
rch/powerpc/platforms/powernv/pci-cxl.c
> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/misc/cxl/
> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/misc/cxl*
> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/uapi/misc/cxl.h
> -F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Documentation/powerpc/cxl.txt
> -F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Documentation/ABI/testing/sysfs-class-cx=
l
>=20

This shouldn't be deleted.

Mikey
