Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 532F01A0014
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 09:33:05 +1000 (AEST)
Message-ID: <1443051185.2492.10.camel@neuling.org>
Subject: Re: [PATCH] powerpc/vdso: Avoid link stack corruption in
 __get_datapage()
From: Michael Neuling <mikey@neuling.org>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Michael Ellerman <michael@ellerman.id.au>, benh
 <benh@kernel.crashing.org>,  Aaron Sawdey <sawdey@us.ibm.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Anton Blanchard <anton@samba.org>, Steve
 Munroe <sjmunroe@us.ibm.com>
Date: Thu, 24 Sep 2015 09:33:05 +1000
In-Reply-To: <CAOJe8K3x56V1PNjo=TNMthqbPV1q_tKNBK6QvT=yCofR=qyt3g@mail.gmail.com>
References: <1442988302.31273.81.camel@neuling.org>
 <CAOJe8K3x56V1PNjo=TNMthqbPV1q_tKNBK6QvT=yCofR=qyt3g@mail.gmail.com>
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


> I've got the following results on POWER7 64bit
> without the patch:
> # ./tb
> time =3D 0.263337
> # ./tb
> time =3D 0.251273
> # ./tb
> time =3D 0.258453
> # ./tb
> time =3D 0.260189
>=20
> with the patch:
> # ./tb
> time =3D 0.241517
> # ./tb
> time =3D 0.241973
> # ./tb
> time =3D 0.239365
> # ./tb
> time =3D 0.240109

Nice, I was expecting a bump there too but didn't test..  Looks like
about 7% to me. =20

Thanks,
Mikey
