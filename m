Return-Path: <marvin24@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33A2E1A0B50
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 19:02:06 +1100 (AEDT)
From: Marc Dietrich <marvin24@gmx.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Geoff Levand <geoff@infradead.org>, Declan Malone <declan.malone@gmail.com>,
 cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: Time to remove platforms/cell?
Date: Fri, 23 Oct 2015 10:00:33 +0200
Message-ID: <4305015.PtpKCQxEF8@fb07-iapwap2>
In-Reply-To: <1445565296.27586.3.camel@ellerman.id.au>
References: <1442467727.25483.0.camel@ellerman.id.au>
 <1445541315.30908.148.camel@infradead.org>
 <1445565296.27586.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2319319.rAx90XdZc5";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart2319319.rAx90XdZc5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Am Freitag, 23. Oktober 2015, 12:54:56 schrieb Michael Ellerman:
> On Thu, 2015-10-22 at 12:15 -0700, Geoff Levand wrote:
> > Hi,
> > 
> > On Fri, 2015-10-09 at 23:13 +0200, Marc Dietrich wrote:
> > > Am Freitag, 9. Oktober 2015, 10:45:42 schrieb Geoff Levand:
> > > > With the 4.2-rc4 kernel, kexec seems to work when CONFIG_SPU_FS=n.
> > > > 
> > > >  I
> > > > 
> > > > have not tried with petitboot release white-09.09.01-15.56 yet though.
> > > 
> > > I guess you mean 4.3-rc4. Still no luck with CONFIG_SPU_FS=n. No output
> > > even with direct calling kexec. Can you put a working kernel/initrd to
> > > some place so I can try this?
> > 
> > I did some more work on this, but still did not find out what the problem
> > is.  Kexec from 4.3 -> 4.3 works, but with the white-09.09.01-15.56
> > 
> > petitboot (2.6.30.9) -> 4.3 gets a kernel panic:
> >  -> early_setup(), dt_ptr: 0x7fff000
> > 
> > Kernel panic - not syncing: BUG: Failed verifying flat device tree, bad
> > version?
> > 
> > I'll look at it some more as I find time.
> 
> That says that the device tree firmware gave you (ie. from kexec), is using
> an old version of the device tree format.
> 
> I can't remember off the top of my head which version you need, but
> basically newer kernels require a newer device tree format. So your kexec
> might be too old?

that reminds me about a different question. I said before that I use plain 
vmlinux for the kernel image. This works at least with 2.6.35 (the newest 
kernel I got booting so far). But I also saw that a device tree is being 
compiled and linked with the kernel to produce a dt image in 
arch/powerpc/boot. Is it possible that newer kernels require a device tree?

Marc

--nextPart2319319.rAx90XdZc5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWKekhAAoJEKyeR39HFBtoTx4IAKDDCYvkULXwhYnvX3UhRPFc
LFldwk66pzE3jPiH43FcXtU+IhOBnlDLhzhewdw/ZgQJ1b+QpHX/k+GM+LtoLG0Y
MiHrkXI8BVptVj7p4rvd887tAqRrAR5ePGFpBhn3g+eJ8n8ZfEVX7hN+MRAX3k7P
0ISqztLdELoZZvPwDMkmo/tkLbNP77zldKvLezEnJOCjAstP8Xot2jA0J3Fo6a94
+z2qC26Tk/dBrCtbxxcZZwxd48pGe3HqN7zt3ldhkNObCG2bTh4z+FoP0mKcMLiN
0b4DXsoCPuU4PkI+oy1i05OmkR2l/7YBOZ9JLXjwqlj4y9swLohS19wFHWEgpmY=
=QNZg
-----END PGP SIGNATURE-----

--nextPart2319319.rAx90XdZc5--
