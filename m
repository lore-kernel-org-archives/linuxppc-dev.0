Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 945A767C72
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 18:26:57 +1000 (EST)
Date: Wed, 4 Oct 2006 18:26:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/7] [POWERPC] implement BEGIN/END_FW_FTR_SECTION
Message-Id: <20061004182652.a8600f11.sfr@canb.auug.org.au>
In-Reply-To: <1159948683.13323.74.camel@localhost.localdomain>
References: <20060926133413.8ca8142e.sfr@canb.auug.org.au>
	<20060926133548.43afd711.sfr@canb.auug.org.au>
	<20060926133651.897ad602.sfr@canb.auug.org.au>
	<20060926133756.071a981f.sfr@canb.auug.org.au>
	<20060926133910.23948614.sfr@canb.auug.org.au>
	<20060926134008.45905bff.sfr@canb.auug.org.au>
	<20060926134222.9e035cc8.sfr@canb.auug.org.au>
	<1159948683.13323.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__4_Oct_2006_18_26_52_+1000_orE5EkB9WevWdK/4"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__4_Oct_2006_18_26_52_+1000_orE5EkB9WevWdK/4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Ben,

On Wed, 04 Oct 2006 17:58:03 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> I'd rather have a single apply_ftr_fixups() that takes the start/stop of
> the fixup table and the value to compare against. That could then be
> called for fw fixups at boot, fw fixups from modules, cpu fixups at
> boot, cpu fixups from modules, and possibly fixups in the vdso's is a
> feature I've been thinking of, and which would be easier with just a
> single function like that.

I agree entirely, but my PowerPC assembly skills are not up to it :-(

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__4_Oct_2006_18_26_52_+1000_orE5EkB9WevWdK/4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFI3BMFdBgD/zoJvwRAgC1AJ45QG+pkwLTnnfikHkarO4ZZ4Ai/QCaAphF
PzmgHzBLQPcqjtqe/zrfLy0=
=mV51
-----END PGP SIGNATURE-----

--Signature=_Wed__4_Oct_2006_18_26_52_+1000_orE5EkB9WevWdK/4--
