Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 24AB5DE1D8
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2009 00:12:04 +1000 (EST)
Date: Sat, 25 Apr 2009 00:11:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Next April 24 : BUG: lock held at task exit time!
Message-Id: <20090425001156.04781613.sfr@canb.auug.org.au>
In-Reply-To: <20090424140445.GL8633@ZenIV.linux.org.uk>
References: <20090424150456.ff35e4ea.sfr@canb.auug.org.au>
	<49F1626D.6080102@in.ibm.com>
	<20090424175509.561c96ad.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0904241249180.20196@blonde.anvils>
	<20090424140445.GL8633@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__25_Apr_2009_00_11_56_+1000_20Mo0V88ywKEUH1j"
Cc: peterz@infradead.org, LKML <linux-kernel@vger.kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
	Ingo Molnar <mingo@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__25_Apr_2009_00_11_56_+1000_20Mo0V88ywKEUH1j
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Fri, 24 Apr 2009 15:04:45 +0100 Al Viro <viro@ZenIV.linux.org.uk> wrote:
>
> Applied, will fold on reorder (since Ingo is asking for what will amount
> to reorder anyway).

Thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__25_Apr_2009_00_11_56_+1000_20Mo0V88ywKEUH1j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknxyKwACgkQjjKRsyhoI8zrOQCeKftgvHyAwioSUsPqttVFONXA
UnIAnRvQjpbBX6SCdzoTe9QEe18DVpSV
=EEhI
-----END PGP SIGNATURE-----

--Signature=_Sat__25_Apr_2009_00_11_56_+1000_20Mo0V88ywKEUH1j--
