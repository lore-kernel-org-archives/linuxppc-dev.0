Return-Path: <marvin24@gmx.de>
From: Marc Dietrich <marvin24@gmx.de>
To: Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org
Subject: Re: Time to remove platforms/cell?
Date: Fri, 09 Oct 2015 23:13:52 +0200
Message-ID: <2993505.617vsrhBxj@fb07-iapwap2>
In-Reply-To: <1444412742.29301.90.camel@infradead.org>
References: <1442467727.25483.0.camel@ellerman.id.au>
 <1444327832.29301.27.camel@infradead.org>
 <1444412742.29301.90.camel@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17617918.sAx2iIpHZI";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart17617918.sAx2iIpHZI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi Geoff,

Am Freitag, 9. Oktober 2015, 10:45:42 schrieb Geoff Levand:
> Hi Marc,
> 
> On Thu, 2015-10-08 at 11:10 -0700, Geoff Levand wrote:
> > > On Mon, 2015-10-05 at 12:27 +0200, Marc Dietrich wrote:
> > > > > I tried with ps3-queue and still no luck. Petitboot just says
> > > > > "Booting kernel
> > > > > ..." thats all - no output.
> > > > > 
> > > > > FW is 3.15 of course
> > > > > Petitboot says (white-09.09.01-15.56)
> > > 
> > > I spent a few minutes on this, and it seems the 2nd stage kernel
> > > panics when
> > > setting up the SPUs.  You could try with CONFIG_SPU_FS=n.
> 
> With the 4.2-rc4 kernel, kexec seems to work when CONFIG_SPU_FS=n.  I
> have not tried with petitboot release white-09.09.01-15.56 yet though.

I guess you mean 4.3-rc4. Still no luck with CONFIG_SPU_FS=n. No output even 
with direct calling kexec. Can you put a working kernel/initrd to some place 
so I can try this?

Marc

--nextPart17617918.sAx2iIpHZI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWGC4QAAoJEKyeR39HFBto1IcH/RDl/QMtXCWYIG7K4YzupZ0l
3AKItP5eiE7Lj7zo1DYCKnm6XGdBI2xa2s2GwdaBhldiS6/dlibWhZxjVoI/cqzH
Y/1Gl4lNkXW7VcfEI/9CZADWWlv/1dAQiWGSkvmwiRCjtpGwEyRxWzF24yUSkh1n
yC/22jKzwt5OJBcgUjp/BfF+7L/TgGFYTH3f1FCH7cbpX3JrdTjEq1lKeHG1/H4y
LZufkRHUoaDJD36cSjFWVPSTSLmB/IaGXGIyqyWuosEMCsaAKsFTkmVzGLpuoC77
PLfr0Fq3Xwj7tPuIvZ6LDKQhgZNJKE72oIO2hmXXIHQxzifXA62lNlX6fkJ0lMU=
=lPAn
-----END PGP SIGNATURE-----

--nextPart17617918.sAx2iIpHZI--
