Return-Path: <sfr@canb.auug.org.au>
Received: from calzone.tip.net.au (calzone.tip.net.au
 [IPv6:2402:b800:7003:1::15])
 by ozlabs.org (Postfix) with ESMTP id B7292B7262
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 08:22:59 +1100 (EST)
Date: Fri, 18 Nov 2011 08:22:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 6/6] poewrpc/85xx: headers cleanup
Message-Id: <20111118082253.f3111cd6b1314c7762d27b2a@canb.auug.org.au>
In-Reply-To: <1321552581-29773-6-git-send-email-dbaryshkov@gmail.com>
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
 <1321552581-29773-6-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__18_Nov_2011_08_22_53_+1100_fdgmNS+60Oa2mTvL"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__18_Nov_2011_08_22_53_+1100_fdgmNS+60Oa2mTvL
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Thu, 17 Nov 2011 21:56:21 +0400 Dmitry Eremin-Solenikov <dbaryshkov@gmai=
l.com> wrote:
>
> Drop lots of unused headers after board files merge/splitup

Again, I am concerned that you may have removed too many includes (though
I didn't explicitly check this time).

In general, these clean ups look great.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__18_Nov_2011_08_22_53_+1100_fdgmNS+60Oa2mTvL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOxXstAAoJEECxmPOUX5FEIVoQAJ2ZbWSqXBjMtj9+okcyGgzR
l9QeBWJLP6gVis4dRD+bFiEZ1MzCDxGklm4baguqaGV6yetN8fP5j/RZuXeme917
WQBzTSZOgPoFJCv7drfxaFkbfrEJ22AkK1RXlcOp+LEpQpixq+nk60arPAJE6E2P
XhWnafZn9fPKIX93bTzprmcwJulauHGb2mdX871p6Jt1WH6HkEBzJuWwJYTs3NEH
VkAfsK/n1ErcGX/83G0xEm85NmYvstsgxRhdnvrdP7QnNkQ87kagcDjoOqe6wEgg
DMybxCAMUH08nrEsDjgsQ1J4F6QgSr89Z35SebKZoTsOOMjLAw+zzgluVTnUi14r
qR0mJlP/cykltcfIvYQOnjTIHLDJ7WSFQ209c5reWwJu9ydmENNKe4akrGgn25rL
PlFRK27oeItr8PDaEC+/jcguAZ1ZpjNz7AAJq2T6igW36LeGUJcW65qQmHnm3PeB
iEFxLo5cvKCBVZcWNz3wYUVa02d4FJENXlI5j2fyHHvxNzsWrIlO+nclnS1OVlkz
V74cC8idSkyKz+VcwJvUWsIwB7wNQ8gmh67WFWnIN4dxXoAb37CJs9WtnRCoNpmI
qrxLm6SXZinUymbwDMtFDaUm6bTVco1VTS1M+Ou81AMFTw6R4xasUgROFTaDxSOJ
wyut/akrSjx2GjEm++7V
=F5Ku
-----END PGP SIGNATURE-----

--Signature=_Fri__18_Nov_2011_08_22_53_+1100_fdgmNS+60Oa2mTvL--
