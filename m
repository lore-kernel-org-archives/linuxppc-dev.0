Date: Wed, 11 Oct 2000 15:26:33 -0400
From: Josh Huber <huber@mclx.com>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
Message-ID: <20001011152633.A1614@missioncriticallinux.com>
References: <20001011141722.A1437@missioncriticallinux.com> <39E4B4D0.FA62D929@student.ethz.ch> <20001011145249.B1437@missioncriticallinux.com> <39E4BAD4.E78B4E3B@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
In-Reply-To: <39E4BAD4.E78B4E3B@student.ethz.ch>; from daenzerm@student.ethz.ch on Wed, Oct 11, 2000 at 09:09:08PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2000 at 09:09:08PM +0200, Michel D?nzer wrote:
> I guess it's because Branden doesn't build the powerpc debs himself or An=
i's
> patches didn't apply cleanly anymore.

Yeah, like Tom said, I think it's because the patches broke x86
systems.  What I think I'm going to do is get the source package for
xfree 4, rsync ani's stuff and rebuild a package.

I'll also upgrade to 2.4 to see if that makes a difference.

btw, dmesg shows that the fbcon system only detected one card -- the
AGP one.

Thanks for the help,
--=20
Josh
| huber@mclx.com |
1024D/6B21489A 61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline


--J/dobhs11T7y2rNN--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
