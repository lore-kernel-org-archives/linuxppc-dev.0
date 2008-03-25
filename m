Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 97728DDF36
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 17:48:24 +1100 (EST)
Date: Tue, 25 Mar 2008 17:48:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Subject: Re: linux-next: Tree for March 20
Message-Id: <20080325174817.6018edd8.sfr@canb.auug.org.au>
In-Reply-To: <20080320045719.GA26938@kroah.com>
References: <20080320143953.8d6b5a60.sfr@canb.auug.org.au>
	<20080320045719.GA26938@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__25_Mar_2008_17_48_17_+1100_3+QPZ9eY/35ys2Dn"
Cc: Theodore Tso <tytso@MIT.EDU>, Dan, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__25_Mar_2008_17_48_17_+1100_3+QPZ9eY/35ys2Dn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, 19 Mar 2008 21:57:19 -0700 Greg KH <greg@kroah.com> wrote:
>
> On Thu, Mar 20, 2008 at 02:39:53PM +1100, Stephen Rothwell wrote:
> >=20
> > driver-core/driver-core-remove-no-longer-used-struct-class_device.patch
> > 	should be merged late

I still need to revert this so that the scsi tree can build (st.c).

> > driver-core/ib-convert-struct-class_device-to-struct-device.patch
> > 	conflicts with the infiniband tree

This still has the same conflicts, but they are papered over by my use of
git-rerere (which remembers my previous merge fixup and applies it for
me).

> > driver-core/pm-make-wakeup-flags-available-whenever-config_pm-is-set.pa=
tch
> > 	breaks non CONFIG_PM builds of drivers/serial/serial_core.c

This one seems to be fixed.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__25_Mar_2008_17_48_17_+1100_3+QPZ9eY/35ys2Dn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH6KA2TgG2atn1QN8RAltjAKCBjPPVm9VsxyWjxZvS7AW7+0zaMQCfdg4J
WLM7eSX2rWNczKNLHsvn+CY=
=wfca
-----END PGP SIGNATURE-----

--Signature=_Tue__25_Mar_2008_17_48_17_+1100_3+QPZ9eY/35ys2Dn--
