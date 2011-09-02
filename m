Return-Path: <lasaine@lvk.cs.msu.su>
Received: from mail.lvk.cs.msu.su (lvk-gate.cmc.msu.ru [212.192.248.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lvk.cs.msu.su", Issuer "CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4098CB6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Sep 2011 22:30:26 +1000 (EST)
Date: Fri, 2 Sep 2011 16:30:10 +0400
From: Alexander Gordeev <lasaine@lvk.cs.msu.su>
To: Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: [PATCH 02/14] dwc/otg: Structure declaration for shared data
Message-ID: <20110902163010.61be424d@apollo.gnet>
In-Reply-To: <CAHM4w1nZkjT2zXB=KfXw0ueOBTLRL2hMFxRYyFwTAoWsdrD9iA@mail.gmail.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<d10bbf1498af371e41907fa07624456d981e56af.1314704557.git.pratyush.anand@st.com>
	<9183dc7afa5b8cde400e9f37f5679d4f@mail.gmail.com>
	<CAHM4w1nHQ1arnTjFyp4dbmp1SBWKJPfREOOR_yykfaVyS48-iA@mail.gmail.com>
	<a85a652e82b2bacdda84d7286b804aa3@mail.gmail.com>
	<CAHM4w1nZkjT2zXB=KfXw0ueOBTLRL2hMFxRYyFwTAoWsdrD9iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/9D6beRehhST1DbnEHaQqnIu";
	protocol="application/pgp-signature"
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com,
	Tirumala Marri <tmarri@apm.com>, linux-usb@vger.kernel.org,
	vipin.kumar@st.com, shiraz.hashim@st.com, Amit.VIRDI@st.com,
	rajeev-dlh.kumar@st.com, Mark Miesfeld <mmiesfeld@apm.com>,
	deepak.sikri@st.com, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/9D6beRehhST1DbnEHaQqnIu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=D0=92 Fri, 2 Sep 2011 17:12:17 +0530
Pratyush Anand <pratyush.anand@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> I will send you those patches.
> But, how to go about it? Will you send next revision of your patces soon,=
 and
> will also include comments for current review?
>=20
> Or,
>=20
> I replly all the comments from community and get agreed about
> modifications first.
> Then I will release next revision with all these modifications and get
> it included. Once these patches are
> included then we can keep on sending further patches over those
> included. This will shorten review time
> and will be easier for inclusion.

What do you think about making a public git repository on github, for
example? I'm using dwc_otg on several MIPS boards and would be happy to
contribute too (at least, fix things pointed out by reviewers to speed
up inclusion).

--=20
  Alexander

--Sig_/9D6beRehhST1DbnEHaQqnIu
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBCAAGBQJOYMxSAAoJEElrwznyooJbJSUIAJnUMUqEiuzTF6pAUT9Pa9B0
RlGr4uR3qhkJybsF4AW6xV/1baVliTmgduHZvAX34t7OQHZFjjdIpVhzHfWS8ejJ
HWH4nbiHuKNSC3NZleVtPGe65dAWqnsDTZ45MBVleWHNpVRofPNXFUr+YQ86aqT2
HdrWaGA8G6q8akOtdcYb7RPXDXlXVJP2b62LxrRUnL5b+T0tWhnl19OAJCACzaJS
Smwv5LeOsBc2+lebyCruHqlVqJURVzmHB7FYoPzp3er/p3RKElk1tQgLMv2ZR7Pr
ySyh9aHAqkgOSP6moZxYfsvGte8hp6FLmdelwNdwNF6jL7+FYSUngnwsASugmkk=
=0I5R
-----END PGP SIGNATURE-----

--Sig_/9D6beRehhST1DbnEHaQqnIu--
