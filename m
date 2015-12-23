Return-Path: <dave@stgolabs.net>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 634C61A001B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 23:18:44 +1100 (AEDT)
Date: Wed, 23 Dec 2015 04:18:26 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH powerpc/next v6 0/4] atomics: powerpc: Implement
 relaxed/acquire/release variants
Message-ID: <20151223121826.GO17386@linux-uzut.site>
References: <1450189457-10589-1-git-send-email-boqun.feng@gmail.com>
 <1450838405.5036.6.camel@ellerman.id.au>
 <20151223105410.GA18401@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
In-Reply-To: <20151223105410.GA18401@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, 23 Dec 2015, Boqun Feng wrote:
>There is one thing we should be aware of, that is the bug:
>
>http://lkml.kernel.org/r/5669D5F2.5050004@caviumnetworks.com
>
>which though has been fixed by:
>
>http://lkml.kernel.org/r/20151217160549.GH6344@twins.programming.kicks-ass.net

Right, and fwiw the testing I did included this fix.
--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJWepESAAoJEF08bMdqyvoCTXsQAJ8hpQ5y4SGUDoO8Wzyn5Uct
Zc9n6bF8fm1NrWTcwLnr0d5jjF6WMokWhXenfFosA2pACV0GhoUF7WyT29bO+pzd
Bz8ZDo9OaVmdyB0Kr8JXCwD9bsjReNsKCcJMQvZ5ls1Jdbx9nNbB3mwiDwNHG6V0
c4/l3vzBqUONlvpyP4C7a2NFM7l2LDf0Q6bV+B5PqxcHrY8w7iymvPDiRM6EzKD+
H/U0ykU7nzRkKK9Q5P5mPbOWDk0jnNka7tiI3VQvX/hmHc1fMHgv3WSwij5NNi95
d6PlaXLqclaukDdFNJnN6rtNiQEx7pJka0kplSwfrekFxfd7D5n2e9aBZ1D5BQrE
YuiiyyYUgxnGvJlAgJvhUykpH+R6X2oWKs7yxF9NNz+Kogu4zKnSwAHfISrGYNgE
JPEOTWc4SP8Qe4d0hHp//3IJgpz1f7H+3PkOCQY3pcY9IJK4PbQ7dSugmbxsib/r
B2kz2A1LWRpINNgP2DBa5OAiXt/EbJZcRKA+05ohn0opiBL2ckSsWdvIG78j4iW/
oP4AUsrAzKcTuLe/Jv4mXToZWrp9ZWqkCgQYie79oFZKb7cuUeltvYT0voWoTspQ
x5FM0JC03BVv3rB6SJXJxtCoKjRKFW6Zz0BAVBv8eu29OO2IaYhRTga1dM3eGPYN
wUfZNM3IDTM0kALK62lG
=2wjc
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
