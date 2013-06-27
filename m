Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 789692C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 14:47:32 +1000 (EST)
Date: Thu, 27 Jun 2013 14:47:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bharat Bhushan <r65777@freescale.com>
Subject: Re: [PATCH 3/6 v5] powerpc: export debug registers save function
 for KVM
Message-Id: <20130627144721.c57718a17c50469db8050520@canb.auug.org.au>
In-Reply-To: <1372225346-5029-4-git-send-email-Bharat.Bhushan@freescale.com>
References: <1372225346-5029-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1372225346-5029-4-git-send-email-Bharat.Bhushan@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__27_Jun_2013_14_47_21_+1000_SMWQdE16V9eV2+6+"
Cc: mikey@neuling.org, kvm@vger.kernel.org, agraf@suse.de,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bharat Bhushan <bharat.bhushan@freescale.com>, tiejun.chen@windriver.com,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__27_Jun_2013_14_47_21_+1000_SMWQdE16V9eV2+6+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 26 Jun 2013 11:12:23 +0530 Bharat Bhushan <r65777@freescale.com> wr=
ote:
>
> diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/=
asm/switch_to.h
> index 200d763..50b357f 100644
> --- a/arch/powerpc/include/asm/switch_to.h
> +++ b/arch/powerpc/include/asm/switch_to.h
> @@ -30,6 +30,10 @@ extern void enable_kernel_spe(void);
>  extern void giveup_spe(struct task_struct *);
>  extern void load_up_spe(struct task_struct *);
> =20
> +#ifdef CONFIG_PPC_ADV_DEBUG_REGS
> +extern void switch_booke_debug_regs(struct thread_struct *new_thread);
> +#endif

We usually don't bother guarding function declarations.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__27_Jun_2013_14_47_21_+1000_SMWQdE16V9eV2+6+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRy8PdAAoJEECxmPOUX5FEoI8P/RMTVTsiHT2RCaoXGOCP1sxj
eChTNLnBLqXjdDvNJTlCmisfwpLHxLGRKo6kYdKSDxKmDhclehDSaKECZ1hgKGK4
x0seA/GdsEL/KGq9DmAcD9wuTOTDupNpldUzcjeIX5mOW47RGPQP/bhNc+1AdLR/
SPc9O3jcG/gnHMM3SvVaBdGzptv886eDh+RjA+7u21k1kOzo8Yr2UAIY86EFRkng
PXLxtrCO4zi1iCan4nXtB0AY9I6CYiqtH9AeTmE6lEEE3d5SB3p9JRYHVMBw7TPw
dRhVwWZS/i3BSne0/2FZxz7Cnofn6P9t33hiAWz0idLb7hkkhkbVfYN7Np8q1Bnm
QCMw4cpvzL844xJgBTLCBbhNnLGxt5lh/ScVGgWXPSsCg1dD9viJnx9giYEmA1Ki
e4XBNQBp/UQlz09zd1ZI+RCk5whd/15GROfpKrD/kq32DJVVznVgQQ7ObDBvLjcE
IsWTGyJhhVzDp5CwbCiajLxCyMGIFqFMRWI8IgXEWYmhquHe0amXU4iQzzg9gCbn
Oqr5NQnjqOYG/ymghw0rnmRnDEXp6GaNdokcRQz82Fb5eZ847GVkIx8QSzb5k+oY
yolV5UYNNDSusZ4RI0AvSFQWWbqvCdOcuu3NYlSmPKwOEtMfdHelq4GBYHIwTliL
QzFxbev03+VWBDpV+Wz9
=atgb
-----END PGP SIGNATURE-----

--Signature=_Thu__27_Jun_2013_14_47_21_+1000_SMWQdE16V9eV2+6+--
