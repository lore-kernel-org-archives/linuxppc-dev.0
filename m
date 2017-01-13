Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0MHB1DcQzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 23:23:33 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christophe LEROY' <christophe.leroy@c-s.fr>, Segher Boessenkool
 <segher@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
CC: Christian Kujau <lists@nerdbynature.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
Date: Fri, 13 Jan 2017 12:23:24 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB02621FA@AcuExch.aculab.com>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
 <alpine.DEB.2.20.99.1701040957380.31470@trent.utfs.org>
 <alpine.DEB.2.20.999.1701091739320.5450@trent.utfs.org>
 <d0e56084-49d7-2486-c2a6-de146331d1c7@c-s.fr>
 <20170111225440.GQ28613@gate.crashing.org>
 <1c81ce1a-33ca-7ba4-56f5-976935deb609@c-s.fr>
 <7604032b-c9ae-e3ce-fcd5-d9e555559f52@c-s.fr>
 <1484234447.2492.34.camel@kernel.crashing.org>
 <20170112180713.GU28613@gate.crashing.org>
 <ca5a9d35-3fe6-9fe3-b490-0fb667aa8c9f@c-s.fr>
In-Reply-To: <ca5a9d35-3fe6-9fe3-b490-0fb667aa8c9f@c-s.fr>
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

From: Christophe LEROY
> Sent: 13 January 2017 12:15
...
> > Which leads to TARGET_LIBC_PROVIDES_SSP being undefined (it would norma=
lly
> > be true for glibc >=3D 2.4), and that is all.  Mystery solved.  Thanks!
> >
>=20
> Is there a way to know during compilation how the compiler will behave,
> in order to select the correct method ?
>=20
> I have drafted a new approach in the kernel that uses -0x7008(r2)
> instead of the global __stack_chk_guard, but how can I select the proper
> approach during kernel compilation in line with the selected GCC ?

Worse, how can you ensure that loadable modules are compiled with the
same option as the rest of the kernel.

	David
