Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0A90867C8A
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 09:36:27 +1100 (EST)
Date: Tue, 12 Dec 2006 01:36:12 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/4] CPM-related stuff resubmit
Message-ID: <20061212013612.18725c25@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_C0IBf33zh0u9dCgPNkFOl7b;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_C0IBf33zh0u9dCgPNkFOl7b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Paul,

Resubmit with proper Sign-off follows. Those fixes are more or less
independent by sense, but here they are in order I applied them to prevent =
confusion.

Fs_enet patch, as usual, included as reference and to represent a full pict=
ure, and will be sent=20
over to netdev.=20

They were applied after the 8xx series in my tree, and though I haven't val=
idated each one for
self-sufficiency, they play nicely in a row. I don't think they'll confuse =
because of linus' merge=20
either, if so, let me know and I'll do a rebase.

--
Thanks, Vitaly

--Sig_C0IBf33zh0u9dCgPNkFOl7b
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFfd1duOg9JvQhSEsRAkzEAJ4uiVFBu5pjrMJLnQXfqDox0aZisQCgkKSE
S+OhpZdf9spy48Xan3X1hCM=
=GdFK
-----END PGP SIGNATURE-----

--Sig_C0IBf33zh0u9dCgPNkFOl7b--
