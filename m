Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id A6BE3B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Mar 2012 09:26:29 +1100 (EST)
Date: Sat, 3 Mar 2012 09:26:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: linux-next: boot failure for next-20120227 and later (pci tree
 related)
Message-Id: <20120303092620.ab0f7379afac65413ef5264e@canb.auug.org.au>
In-Reply-To: <CAErSpo6xQa4Rnv+RkkXCRjQ2HDZdBhorRv2c6pmWyXqRzhM4Vw@mail.gmail.com>
References: <20120302170638.3d172369d04335d9b921a28c@canb.auug.org.au>
 <CAErSpo6xQa4Rnv+RkkXCRjQ2HDZdBhorRv2c6pmWyXqRzhM4Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Sat__3_Mar_2012_09_26_20_+1100_hRmsrGX2SL+pqi1b"
Cc: linux-next@vger.kernel.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sat__3_Mar_2012_09_26_20_+1100_hRmsrGX2SL+pqi1b
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Fri, 2 Mar 2012 10:10:02 -0700 Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> Thanks a lot for the test report and the bisection.  I wish I had a
> machine to test on so I wouldn't have to bother you about it.

That's OK.

> Any chance you could point me at the complete before/after dmesg logs?
>  There should be information about the PCI host bridge apertures and
> offsets in the "after" log.

I have put the logs up at http://ozlabs.org/~sfr/console-bad.log and
console-good.log.  They have been editted to set the initcall return
timings to "x" usecs just for ease of diffing, otherwise verbatim.

>  If that's not enough, we might need to
> collect new before/after logs with something like this
> (whitespace-mangled):

I'll defer to Ben as to whether that would help as I don't have easy
access to the machine until Monday anyway.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Sat__3_Mar_2012_09_26_20_+1100_hRmsrGX2SL+pqi1b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPUUkMAAoJEECxmPOUX5FEEA4P/R8hQpYip0koii300ZCcuonq
3eg4ex1dCQg7hj/Bl+oVk+hEEiH/gnmz4Oqrhpl0fsmtAf9jt+MfguyR9gVCyvXJ
2ap2/XInpiMjj62LLLqHQ+orcfxIGnWuT5Wuh68TT81W6d536IdWWMhHHl/LJb/q
aR9ohvEv0Q4re5lPJeYuFL5wO0rCcdpdB3ZQP7S+u75xgMvDXZ/IrTE7TFUGmEwU
Egqm+kkiylNR+TtemaCa5YYiLcKFWHaK3oLGqaguCUPd7rAO2qKWrQDIvJiUTaAr
upl51Vycc2b7/46kS0LzVah6poNQmSiHnEIC2cq2PAMPui46x8ZqgE3OkpnFX3j2
xhM7pCVlBONH53NNsQhzmwFjUvdwAYqFVHSchpx7oF+5cWp7o7Z0PowbleQYa2Ps
iPvgNp23YUbw0B80B3YnIsOqWC7PVJVDEksWLBPJdRZXPHDM2ZMf0BIm75hW5CSD
mqaCS/pOLfRT9ghs1eGtfWnjxi0/msdGijsJdCR7GqB61XHKoAyWsDBR5RDwN8cd
n4ypm6mzBJzbRVXMdZGPR9Ki4dVvEOF4k8mGLOBEb/tB7Ege1fTS/svQXUqtCus5
+ZOFS8btoIJ/tFlCKkJNRYUb15hQRT+ki6lDz2MeG6eKMsLOxKDtfOZkXQ13fFn9
pY1pabiPsEIb+/aUOVue
=0TEB
-----END PGP SIGNATURE-----

--Signature=_Sat__3_Mar_2012_09_26_20_+1100_hRmsrGX2SL+pqi1b--
