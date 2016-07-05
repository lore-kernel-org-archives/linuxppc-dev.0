Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rk4Ph51jpzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 10:24:08 +1000 (AEST)
Message-ID: <1467678247.30027.29.camel@neuling.org>
Subject: Re: powerpc/mm: Add a parameter to disable 1TB segs
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Oliver O'Halloran
 <oohall@gmail.com>,  linuxppc-dev@lists.ozlabs.org
Date: Tue, 05 Jul 2016 10:24:07 +1000
In-Reply-To: <3rjc771dmCz9sCg@ozlabs.org>
References: <3rjc771dmCz9sCg@ozlabs.org>
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

On Mon, 2016-07-04 at 16:09 +1000, Michael Ellerman wrote:
> On Mon, 2016-04-07 at 00:44:04 UTC, Oliver O'Halloran wrote:
> >=20
> > This patch adds the kernel command line parameter "no_tb_segs" which
> > forces the kernel to use 256MB rather than 1TB segments. Forcing the
> > use
> > of 256MB segments makes it considerably easier to test code that
> > depends
> > on an SLB miss occurring.
> That's a fairly awful name :)
>=20
> Can you call it "disable_1T_segments" ?
>=C2=A0
>=20
> It should also be mentioned in Documentation/kernel-parameters.txt, with
> emphasis that it's a debug option and powerpc only.

To that end, should we add "powerpc_" at the start of the option?

Mikey
