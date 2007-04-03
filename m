Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 3 Apr 2007 18:20:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: cbe_cpufreq.c initialisation
Message-Id: <20070403182037.93221d65.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__3_Apr_2007_18_20_37_+1000_tB1wvVtuGAxBuwVO"
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__3_Apr_2007_18_20_37_+1000_tB1wvVtuGAxBuwVO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi all,

In cbe_cpufreq_cpu_init, there is this code:

	max_freq = (u32*) get_property(cpu, "clock-frequency", NULL);
        // we need the freq in kHz
        *max_freq /= 1000;

does this really need to modify the property value in place?

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__3_Apr_2007_18_20_37_+1000_tB1wvVtuGAxBuwVO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGEg5dFdBgD/zoJvwRAluUAJoCWJ7GVraXIjkXPCe5AUwgiLi7YgCffkFx
zNAIXPQQxc9L20Mtn/xIwtA=
=ntks
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Apr_2007_18_20_37_+1000_tB1wvVtuGAxBuwVO--
