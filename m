Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] kdump: Fix for machine checkstop on DMA fault
Date: Thu, 23 Mar 2006 17:06:27 +1100
References: <44222462.2030103@us.ibm.com>
	<20060323053854.GA17693@pb15.lixom.net>
In-Reply-To: <20060323053854.GA17693@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1200099.ONV75UaBky";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200603231706.35508.michael@ellerman.id.au>
Cc: Milton Miller <miltonm@bga.com>, Paul Mackerras <paulus@samba.org>,
	Olaf Hering <olh@suse.de>, ellerman@au1.ibm.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1200099.ONV75UaBky
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 23 Mar 2006 16:38, Olof Johansson wrote:
> On Wed, Mar 22, 2006 at 08:30:26PM -0800, Haren Myneni wrote:
> > Paul, If you are OK with this fix, please send it upstream.
> >
> > Thanks
> > Haren
> >
> > - Some machines checkstop on dma protection fault for ongoing DMA left
> > in the first kernel. Since, we do not shutdown devices before the kdump
> > boot, let them continue DMA to old kernel space.
>
> How is this solved for regular kexec, doesn't the same problem exist
> there?

The idea for normal kexec is that the kernel should have shut everything do=
wn=20
properly. It's a bug if there are still DMAs going on. Hopefully.

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart1200099.ONV75UaBky
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEIjrrdSjSd0sB4dIRAi91AKDI/KqF1fMpMIvPU/QO1Lr0x1QkuACfT9mS
I1nYlvht4Nf411vvYNcuplo=
=8nhO
-----END PGP SIGNATURE-----

--nextPart1200099.ONV75UaBky--
