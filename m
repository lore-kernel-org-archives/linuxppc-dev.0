Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 973EDDDEAB
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 20:57:52 +1000 (EST)
Date: Wed, 2 May 2007 20:57:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] via-pmu: remove LED sleep notifier
Message-Id: <20070502205741.72dc191b.sfr@canb.auug.org.au>
In-Reply-To: <1178084161.13233.16.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178084161.13233.16.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__2_May_2007_20_57_41_+1000_t8bk18F6mOqV.E5m"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__2_May_2007_20_57_41_+1000_t8bk18F6mOqV.E5m
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 02 May 2007 07:36:01 +0200 Johannes Berg <johannes@sipsolutions.net> wrote:
>
> --- wireless-dev.orig/drivers/macintosh/via-pmu-led.c	2007-05-01 11:35:45.354734191 +0200
> +++ wireless-dev/drivers/macintosh/via-pmu-led.c	2007-05-01 11:36:25.454734191 +0200
> @@ -31,7 +31,8 @@ static spinlock_t pmu_blink_lock;
>  static struct adb_request pmu_blink_req;
>  /* -1: no change, 0: request off, 1: request on */
>  static int requested_change;
> -static int sleeping;
> +
> +extern int pmu_sys_suspended;

Extern declarations should be in include files.
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__2_May_2007_20_57_41_+1000_t8bk18F6mOqV.E5m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGOG6vFdBgD/zoJvwRAleuAJ9YaIxsZZIlBE3DDgCOar65ghhn1ACdHsZz
48OP76rQop379FNPa5hVEn4=
=/sEt
-----END PGP SIGNATURE-----

--Signature=_Wed__2_May_2007_20_57_41_+1000_t8bk18F6mOqV.E5m--
