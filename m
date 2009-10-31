Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 14B79B7C1B
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 15:37:27 +1100 (EST)
Date: Sat, 31 Oct 2009 15:37:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 19/27] Export symbols for KVM module
Message-Id: <20091031153719.10a4e61b.sfr@canb.auug.org.au>
In-Reply-To: <1256917647-6200-20-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
	<1256917647-6200-20-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__31_Oct_2009_15_37_19_+1100_QzbMyeN4MVJyl+mI"
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org,
	bphilips@suse.de, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sat__31_Oct_2009_15_37_19_+1100_QzbMyeN4MVJyl+mI
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Fri, 30 Oct 2009 16:47:19 +0100 Alexander Graf <agraf@suse.de> wrote:
>
> diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ks=
yms.c
> index c8b27bb..baf778c 100644
> --- a/arch/powerpc/kernel/ppc_ksyms.c
> +++ b/arch/powerpc/kernel/ppc_ksyms.c
> @@ -163,11 +163,12 @@ EXPORT_SYMBOL(screen_info);
>  #ifdef CONFIG_PPC32
>  EXPORT_SYMBOL(timer_interrupt);
>  EXPORT_SYMBOL(irq_desc);
> -EXPORT_SYMBOL(tb_ticks_per_jiffy);
>  EXPORT_SYMBOL(cacheable_memcpy);
>  EXPORT_SYMBOL(cacheable_memzero);
>  #endif
> =20
> +EXPORT_SYMBOL(tb_ticks_per_jiffy);

Since you are moving this anyway, how about moving it into
arch/powerpc/kernel/time.c where tb_ticks_per_jiffy is defined.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__31_Oct_2009_15_37_19_+1100_QzbMyeN4MVJyl+mI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrrvv8ACgkQjjKRsyhoI8zs4wCgly+qZbxtz5zsF5AflIThSGwJ
XckAoIVQuh1PEOxtH2F5/35NAEvTECTa
=1EIY
-----END PGP SIGNATURE-----

--Signature=_Sat__31_Oct_2009_15_37_19_+1100_QzbMyeN4MVJyl+mI--
