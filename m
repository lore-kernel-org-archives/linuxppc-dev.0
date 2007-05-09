Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 42D3EDDF0A
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 02:39:57 +1000 (EST)
Date: Thu, 10 May 2007 02:39:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: Build failure with Linus' tree
Message-Id: <20070510023958.4b4dbf1f.sfr@canb.auug.org.au>
In-Reply-To: <20070509161723.GA20759@deepthought>
References: <20070509161723.GA20759@deepthought>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_May_2007_02_39_58_+1000_Pn2xQiaPKZ3v1s1z"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_May_2007_02_39_58_+1000_Pn2xQiaPKZ3v1s1z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Ken,

On Wed, 9 May 2007 17:17:23 +0100 Ken Moffat <zarniwhoop@ntlworld.com> wrote:
>
>  On my G5 I'm getting this on a copy of Linus' tree I pulled a bit
> over two hours ago:
>
>   LD      .tmp_vmlinux1
> arch/powerpc/sysdev/built-in.o: In function `.iommu_init_late_dart':
> dart_iommu.c:(.init.text+0xf10): undefined reference to
> `.register_nosave_region_late'
> make: *** [.tmp_vmlinux1] Error 1
>
>  I suppose that something is wrong in sysdev/dart_iommu.c, probably
> related to suspend changes - if I need to bisect, it will take some
> time (this is an SMU powermac, dead slow) so I'll mention it here
> now.

Should be already fixed in Paulus' latest tree (and in Linus' tree after
he pulls).

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_May_2007_02_39_58_+1000_Pn2xQiaPKZ3v1s1z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQfliFdBgD/zoJvwRApzlAJ4v+ni4Xua4D3txiDYgTUSw/WUb8gCfZw9c
Lca4N0LLCpv4ThL6Le6Z5Gw=
=kJm1
-----END PGP SIGNATURE-----

--Signature=_Thu__10_May_2007_02_39_58_+1000_Pn2xQiaPKZ3v1s1z--
