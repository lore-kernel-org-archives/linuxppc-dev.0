Return-Path: <David.Laight@ACULAB.COM>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szZyQ2nl7zDt5q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 02:06:06 +1100 (AEDT)
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3szZyP70NDz9vH7
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Oct 2016 02:06:04 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Balbir Singh' <bsingharora@gmail.com>, Michael Ellerman
 <mpe@ellerman.id.au>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: RE: [RFC PATCH 2/3] powerpc/pseries: Define & use a type for the
 plpar_hcall() retvals
Date: Wed, 19 Oct 2016 14:38:25 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0205C94@AcuExch.aculab.com>
References: <1476780032-21643-1-git-send-email-mpe@ellerman.id.au>
 <1476780032-21643-2-git-send-email-mpe@ellerman.id.au>
 <b922cd6c-a44d-6950-93d7-6645fd1f7fac@gmail.com>
 <87lgxk4l2p.fsf@concordia.ellerman.id.au>
 <360be313-c3ad-495c-82e1-13a8364dc76d@gmail.com>
In-Reply-To: <360be313-c3ad-495c-82e1-13a8364dc76d@gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh
> Sent: 19 October 2016 15:00
...
> Here is an example
>=20
> -	*slot =3D retbuf[0];
> +	*slot =3D retvals.v[0];
>=20
> Could we hide retvals.v[0] under a macro like
>=20
> *slot =3D hcalls_ret_val(retvals, 0);

Ugg..

> Since we could end up with similar issues if
> someone dereferenced retvals.v[4]

The compiler will detect that these days.

	David
