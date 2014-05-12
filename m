Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 12 May 2014 10:19:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: add scottwood/linux.git
Message-ID: <20140512101943.40659bcc@canb.auug.org.au>
In-Reply-To: <20140512082336.501fa8a2@canb.auug.org.au>
References: <20140320042527.GA23206@home.buserror.net>
 <1395616617.3460.109.camel@pasglop>
 <1395617608.3460.113.camel@pasglop>
 <1395709794.12479.411.camel@snotra.buserror.net>
 <1399670133.15726.440.camel@snotra.buserror.net>
 <20140512082336.501fa8a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7=jc7vLZP/fV.F1z=keletk"; protocol="application/pgp-signature"
Cc: Scott Wood <scottwood@freescale.com>, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/7=jc7vLZP/fV.F1z=keletk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Scott,

On Mon, 12 May 2014 08:23:36 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Fri, 9 May 2014 16:15:33 -0500 Scott Wood <scottwood@freescale.com> wr=
ote:
> >
> > On Mon, 2014-03-24 at 20:09 -0500, Scott Wood wrote:
> > > On Mon, 2014-03-24 at 10:33 +1100, Benjamin Herrenschmidt wrote:
> > > > On Mon, 2014-03-24 at 10:16 +1100, Benjamin Herrenschmidt wrote:
> > > > > On Wed, 2014-03-19 at 23:25 -0500, Scott Wood wrote:
> > > > > > The following changes since commit c7e64b9ce04aa2e3fad7396d92b5=
cb92056d16ac:
> > > > > >=20
> > > > > >   powerpc/powernv Platform dump interface (2014-03-07 16:19:10 =
+1100)
> > > > > >=20
> > > > > > are available in the git repository at:
> > > > > >=20
> > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux=
.git next
> > > > > >=20
> > > > > > for you to fetch changes up to 48b16180d0d91324e5d2423c6d53d97b=
be3dcc14:
> > > > > >=20
> > > > > >   fsl/pci: The new pci suspend/resume implementation (2014-03-1=
9 22:37:44 -0500)
> > > > >=20
> > > > > Stephen just informed me that your tree wasn't in -next ... Kumar=
's
> > > > > still is.
> > > > >=20
> > > > > Can you guys fix that up ? I somewhat rely on the FSL stuff to si=
mmer
> > > > > in -next on its own.
> > >=20
> > > Stephen, what's the process for adding a tree?
> >=20
> > ping
>=20
> Sorry, for the delay.
>=20
> Just send me a git URL for your tree, and a list of the people I should
> contact in case of conflicts/build/fetch problems and cc the
> appropriate people/lists.
>=20
> I also assume that this will actually replace Kumar's tree?

[Preempting your reply :-)]

I have added the above tree from today (and called it "fsl") with you
as the sole contact.  Let me know if you need anything different.  I
have also removed the galak tree.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/7=jc7vLZP/fV.F1z=keletk
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTcBOlAAoJEMDTa8Ir7ZwV3ZAP/3l96o28UBC7IGhhjMMjOZhx
0VBLCQcAN69tjV1WbNAdKJqQHzNOilxxnTVizJTCFbwrFD6g6+Kopx7v7OraCpzj
/md1vCyEUnrDgwKcpd4I26rM3Fj8mGBX5ejv4q4JRUy3/iJ4/fG/5Tpay7cgW2HA
gPWqHsDgHmdgYtdWsqkG7cqqbtz6LSujJoBQSNM5IAf/4Hu5R6+9A62WVcDud4Y1
+ZqkQSrxXYgupl/0VJcw6KI1BHi99nFQCH1ATH8I9pLrwPrFpwiSnMZxMQcUkJS5
LPCj/JuzEGMfhW2fv81/JJR3iIVHGVqSMqLSr0KxZnv0BuP/TeD56jJyUOKMOLEz
HYBxJ7r2SlP07GHNKkhILIuxhWScuT2AjYQZZB/B9258Osd2fbTY/yoktksWSvJz
QP/GnORFfnVVLME9aroAXTJD0b5xM7Yacspb+v8c7imxAk2bEPWFS9PeLYgSMuKx
vWdR4XBdtynYkYMCzn1QZL3uSgUHiyigdpdRtk/iosaO3OBnUy6AIRCenh+/p9kp
zVmaz94z7TjcvWpTC/9F+iv9Q6Bya+8JUamhBcNkfYk7z0PBfEHcD80uiNcg4YvB
yiRtJDoUtfAoK4kvx4vpYLuF9/HX4xeljPTMz6bj2bC9Q20cV/yXmlTt98UHKsIE
W579L0DNaTOyCEK1+tne
=40oe
-----END PGP SIGNATURE-----

--Sig_/7=jc7vLZP/fV.F1z=keletk--
