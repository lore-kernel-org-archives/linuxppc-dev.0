Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 3FD502C0342
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 12:47:24 +1100 (EST)
Date: Tue, 5 Mar 2013 12:47:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] powerpc: Wireup the kcmp syscall to sys_ni
Message-Id: <20130305124721.cb1b2eb1ac29130b6ce92d7b@canb.auug.org.au>
In-Reply-To: <1362443994-26580-1-git-send-email-tony@bakeyournoodle.com>
References: <1362443994-26580-1-git-send-email-tony@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__5_Mar_2013_12_47_21_+1100_.=mTW0NCMC1x9Bsu"
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__5_Mar_2013_12_47_21_+1100_.=mTW0NCMC1x9Bsu
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Tue,  5 Mar 2013 11:39:54 +1100 Tony Breeds <tony@bakeyournoodle.com> wr=
ote:
>
> diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm=
/systbl.h
> index 535b6d8..289bb52 100644
> --- a/arch/powerpc/include/asm/systbl.h
> +++ b/arch/powerpc/include/asm/systbl.h
> @@ -358,3 +358,4 @@ SYSCALL_SPU(setns)
>  COMPAT_SYS(process_vm_readv)
>  COMPAT_SYS(process_vm_writev)
>  SYSCALL(finit_module)
> +SYSCALL(ni_syscall)

It is probably worth commenting what syscall should be there.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__5_Mar_2013_12_47_21_+1100_.=mTW0NCMC1x9Bsu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRNU6pAAoJEECxmPOUX5FEdTgP/07P9kiGxa34hT2ODzbyAeox
i73K0cq/g89N15g1bthq/OLw2LW0f1DEjSNbKxVvzcAsvQmX77blH8GfMcza1thH
egemGI5dV7yO7KFjO9IMwxsotd4FjuPGrStM+4dQwvlP0z2BMfgycwMppEh0E5ZL
XjCDf+PSTXQOX++iD8xdDhXzP+sS6RkgF62WC9wkbrJqP7xOk0WlTFdeKcHXcJ2k
+FoqHPOSRZQzfiIiwjj68pr6mWhe1tQVR2Y+Ov1l0SzZ4dJHabctuv7KTILYNrsG
hmdQV4jclDj1/33mJGeZ/w9J3gu54HwWwDto2bNWCcmhoJLbu+bLLr34CiqS/+2F
lm7raAUwwGZuJHwWtXzm+ut+Y+8Ov/my5PK2BLRiBDgwfg+2CYcoC/Jokv3PrBgi
tgy5F/AJT2bZuSViWoCRQguj/5qTUkdwdNbG07CdFUMDBnThzKeMCckYv6vM8H4E
wUjFFe8HVebPRt+VmGr1avvf7G2Y248iadiL0LF7aYTaLAN9G4tro/I8BtqIpEZe
IjksZmEGLvNyS2sFQo5uXqh6NWMmCB5n1eHIuwnbd4eRmxEGhUT7ONFINxPZOsho
T1LsQyp3n+WJ84L8ZJEp7Y17iz4Y+PXQ1UUQ6XvykVGmG+0Fpl6dzFWrPC+YUb4F
PpncCOEvdAkcV071uhZQ
=i251
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Mar_2013_12_47_21_+1100_.=mTW0NCMC1x9Bsu--
