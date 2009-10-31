Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CC9A0B7C1E
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 15:41:04 +1100 (EST)
Date: Sat, 31 Oct 2009 15:40:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 20/27] Split init_new_context and destroy_context
Message-Id: <20091031154059.750d7213.sfr@canb.auug.org.au>
In-Reply-To: <1256917647-6200-21-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
	<1256917647-6200-21-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__31_Oct_2009_15_40_59_+1100_OCeSF4ZC1zwlB_MI"
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

--Signature=_Sat__31_Oct_2009_15_40_59_+1100_OCeSF4ZC1zwlB_MI
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Fri, 30 Oct 2009 16:47:20 +0100 Alexander Graf <agraf@suse.de> wrote:
>
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -23,6 +23,11 @@ extern void switch_slb(struct task_struct *tsk, struct=
 mm_struct *mm);
>  extern void set_context(unsigned long id, pgd_t *pgd);
> =20
>  #ifdef CONFIG_PPC_BOOK3S_64
> +extern int __init_new_context(void);
> +extern void __destroy_context(int context_id);
> +#endif
> +
> +#ifdef CONFIG_PPC_BOOK3S_64

don't add the #endif/#ifdef pair ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__31_Oct_2009_15_40_59_+1100_OCeSF4ZC1zwlB_MI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrrv9sACgkQjjKRsyhoI8yBHgCeNQ+Mw8Fa+viedzjRnipIOMqo
Ra0AoLL+4BzuwNNlvlB9XTVgBRroE9Qz
=kOzB
-----END PGP SIGNATURE-----

--Signature=_Sat__31_Oct_2009_15_40_59_+1100_OCeSF4ZC1zwlB_MI--
