Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CEC8E1A0C3D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 14:36:29 +1100 (AEDT)
Date: Tue, 20 Jan 2015 14:36:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/7] powerpc: regenerate ppc64 and pseries defconfigs
Message-ID: <20150120143623.369f3571@canb.auug.org.au>
In-Reply-To: <1421709865-6368-1-git-send-email-anton@samba.org>
References: <1421709865-6368-1-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/srxNK5clAM9R8an5vlTU+qJ"; protocol="application/pgp-signature"
Cc: nacc@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/srxNK5clAM9R8an5vlTU+qJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Tue, 20 Jan 2015 10:24:19 +1100 Anton Blanchard <anton@samba.org> wrote:
>
> Regenerate defconfigs using make savedefconfig.

I assume that you checked that we end up with (basically) the
same .config (as some previous (to be defined but sane) release)?  :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/srxNK5clAM9R8an5vlTU+qJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUvc08AAoJEMDTa8Ir7ZwV8ZoP/RaJk7ubnZST25uAawa+7CP6
H5exwdBCBvI53pFPcUIlPqep6VUfaRcHZAG2nCGAiG+7ndMjC1jow3orRpHm6Ynz
SVXTUY6ZMXnwIssgxD/aqwRabiC/hudUvYz0h1j6a2QSSIuK74AkV7269fWgB12z
PsbWn0qqTd1Ychq/462hklJVmv2BCIpbkRQnqRBeDUQETqBaUun9e5cG7oRsDJd4
SwLLJYk+X6H25oFG7sMEsTjgKXlXoI5LiWpAB9C0Q4WXAFdO9DAI3aokgTQDiRc8
PMoyISi0a1CzGtkw5EJlCpFCba+mVP5bV17wlEnWhaKtglRVhB4m017op7I54W5r
kgE4iRyBuowBRZIcDmr9opjewuLvQ857HzUXl1H4GG5mQWj/7tmeSqyNwRzX2EEw
suKwt7fJYJjKGTCmRJ/pQ1DfOvoogOE/V8CEHbSOM8bwNmSHJgNq0bKx6JSTc/H9
+kGgq8rUAVExRE0RPBgjmgdmPhQzsZCD3jsb0VV7XrogdQ/4D7caCSdCyvFyHMSA
S9UMUY5RQas9jWo7WHrNaZBU9RAdvfIEPoBLy5s84lz8K+dJTopYyLN3aNIrEoQi
xcCeZz/rWofuX1ws8Q3oxcOLalCEyXPcWdr1My00ayfYuf67er/DyXuYNLjxoFtF
CDIF4ZrnnKvUQ5FzK33C
=AQ1E
-----END PGP SIGNATURE-----

--Sig_/srxNK5clAM9R8an5vlTU+qJ--
