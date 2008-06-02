Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] ftrace: powerpc clean ups
From: Michael Ellerman <michael@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <Pine.LNX.4.58.0805221429020.18018@gandalf.stny.rr.com>
References: <20080515034942.109223655@goodmis.org>
	<20080515035918.896765954@goodmis.org>
	<1211292277.7960.8.camel@localhost>
	<Pine.LNX.4.58.0805221429020.18018@gandalf.stny.rr.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vUkyxTTM+CreoaEPRw+2"
Date: Mon, 02 Jun 2008 12:15:07 +1000
Message-Id: <1212372907.14511.18.camel@localhost>
Mime-Version: 1.0
Cc: proski@gnu.org, a.p.zijlstra@chello.nl,
	Soeren Sandmann Pedersen <sandmann@redhat.com>,
	Pekka Paalanen <pq@iki.fi>, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	paulus@samba.org, Ingo Molnar <mingo@elte.hu>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-vUkyxTTM+CreoaEPRw+2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-05-22 at 14:31 -0400, Steven Rostedt wrote:
> This patch cleans up the ftrace code in PowerPC based on the comments fro=
m
> Michael Ellerman.

Hi Steven,

Thanks for that.

I posted some patches last week, also in my git tree[1], that should
allow you to use create_branch() in your code (and also facilitate some
other things I wanted to do). I also added a #define for NOP also.

If/when my patches go into powerpc-next I'll do a patch against
linux-next for ftrace to use them.

cheers

[1]: http://git.kernel.org/?p=3Dlinux/kernel/git/mpe/linux-2.6.git;a=3Dsumm=
ary

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-vUkyxTTM+CreoaEPRw+2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIQ1erdSjSd0sB4dIRAp5HAJ0crqf+Y5Gk6KWHN2t/WDt3rFhEAwCdExPN
UkDm5XeSipwInpy82KDTHqU=
=p+P1
-----END PGP SIGNATURE-----

--=-vUkyxTTM+CreoaEPRw+2--
