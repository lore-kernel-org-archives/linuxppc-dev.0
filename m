Return-Path: <boqun.feng@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD43A1A115F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 13:07:40 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id l9so26605351oia.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jan 2016 18:07:40 -0800 (PST)
Date: Wed, 6 Jan 2016 10:07:07 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 2/4] powerpc: atomic: Implement atomic{, 64}_*_return_*
 variants
Message-ID: <20160106020707.GA27312@fixme-laptop.cn.ibm.com>
References: <1450189457-10589-1-git-send-email-boqun.feng@gmail.com>
 <1450189457-10589-3-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
In-Reply-To: <1450189457-10589-3-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I will resend this one to avoid a potential conflict with:

http://article.gmane.org/gmane.linux.kernel/2116880

by open coding smp_lwsync() with:

__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory");

Regards,
Boqun

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWjHbHAAoJEEl56MO1B/q4yA4H/3NzoTjvhg+7yrysZtSS5lbO
2Viq5TmPDG+0hKPdGNrasZggjNoYCgmJJc2tq1NBhxmSafbnwuh7vyC9YpCYZHdb
g+IFN81szC9x8DkZ5R3wnE08FiucYkIAJse0oqGXPEqg2/M2eCH76jmfyqokd/VB
+tBbBX5hC5ijuD6zP3/DOO1Vc8buz1UAImu9ezOWo3mnVnHTyY8DIWpFS8Lzyf/i
P1d+VeY3wyR91u5VdCpBTTOSd0TDFOp5EaBOaEQ8f9Gxu9gXwR7soJ67lzw3bOWf
+1HMfwCltJzQH7HmgRcERK7DhZdSpLYBJ2/1pFcAFsPgI7+F9UGe0d56pUCP9nI=
=e4Et
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
