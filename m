Return-Path: <lasaine@lvk.cs.msu.su>
Received: from mail.lvk.cs.msu.su (lvk-gate.cmc.msu.ru [212.192.248.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lvk.cs.msu.su", Issuer "CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B6936B6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 16:56:44 +1000 (EST)
Date: Wed, 31 Aug 2011 10:49:43 +0400
From: Alexander Gordeev <lasaine@lvk.cs.msu.su>
To: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 00/14] Modifications for DWC OTG since v13
Message-ID: <20110831104943.01d11a55@apollo.gnet>
In-Reply-To: <CAH9JG2WzpYgM0r+Zgf2cnL94-qG4XmVm3RxYqRRezHhMgeovYQ@mail.gmail.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<bff62861217ab3d8dbf8041e2c4d1c8c@mail.gmail.com>
	<CAHM4w1nWTxfMTSTbmt4vnWAKhj4JisJf1f0SjirOt7Z9vjORoA@mail.gmail.com>
	<CAH9JG2WzpYgM0r+Zgf2cnL94-qG4XmVm3RxYqRRezHhMgeovYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/J8+9bCvxNqDJdWP24ThGi_w";
	protocol="application/pgp-signature"
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, rajeev-dlh.kumar@st.com,
	bhupesh.sharma@st.com, Tirumala Marri <tmarri@apm.com>,
	Pratyush Anand <pratyush.anand@gmail.com>, vipin.kumar@st.com,
	shiraz.hashim@st.com, Amit.VIRDI@st.com,
	linux-usb@vger.kernel.org, Mark Miesfeld <mmiesfeld@apm.com>,
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

--Sig_/J8+9bCvxNqDJdWP24ThGi_w
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

=D0=92 Wed, 31 Aug 2011 10:18:42 +0900
Kyungmin Park <kmpark@infradead.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On Wed, Aug 31, 2011 at 12:46 AM, Pratyush Anand
> <pratyush.anand@gmail.com> wrote:
> > On Tue, Aug 30, 2011 at 8:57 PM, Tirumala Marri <tmarri@apm.com> wrote:
> >> <-----Original Message-----
> >> <From: Pratyush Anand [mailto:pratyush.anand@st.com]
> >> <Sent: Tuesday, August 30, 2011 4:58 AM
> >> <To: linux-usb@vger.kernel.org
> >> <Cc: tmarri@apm.com; linuxppc-dev@lists.ozlabs.org; fchen@apm.com;
> >> <mmiesfeld@apm.com; shiraz.hashim@st.com; deepak.sikri@st.com;
> >> <vipulkumar.samar@st.com; rajeev-dlh.kumar@st.com; vipin.kumar@st.com;
> >> <bhupesh.sharma@st.com; viresh.kumar@st.com; Amit.VIRDI@st.com; Pratyu=
sh
> >> <Anand
> >> <Subject: [PATCH 00/14] Modifications for DWC OTG since v13
> >> <
> >> <These patches are based on:http://patchwork.ozlabs.org/patch/89560/
> >> <After not getting any reply from developers, I started to do
> >> <modifications for my platform (SPEAr1340).
> >> <I have done modifications in such a way that all the code in
> >> <driver/usb/dwc/ would be platform independent.
> >> <I have tested this code for host/device/dma/slave mode.
> >> <My fifo configuration is dedicated and dynamic.
> >>
> >> [Tirumala Marri] We are working on our next release of patches. They
> >> should be coming out soon.
> >
> > Oh, thats great !!
> > Actually, I did not get any reply of my previous mail on your patch rel=
ease.
> > I thought no one is maintaining., and so I sent them with my modificati=
ons,
> > after testing them in all dev/host/otg mode.
> >
> > Regards
> > Pratyush
>=20
> Hi,
>=20
> Can you provide the git repo to test?
> and I wonder what's the difference between dwc (from you) and dwc3
> (from Felipe Balbi). I think it's dwc targets for usb 2.0 and dwc3 for
> usb 3.0.

It doesn't look the same. At least, register definitions are quite
different.

--=20
  Alexander

--Sig_/J8+9bCvxNqDJdWP24ThGi_w
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBCAAGBQJOXdmHAAoJEElrwznyooJbxV8H/ifPFiMdSa8e1jlA4KPzDBpB
dG4A+qaJHtXJ/m8QS2DvuYVOA+/QN3Q9VXqgYW8D5UOyt7VesKnzFRtddwXR5sU3
x8XEIao55F6fLbXKmdDCHRJEGTLaASMCjuLlMp0FtMwZKJ5sy4P3vMdhhqbsa5WE
3f0MLGnKKcuOmBIQuxpjO8PeUgdROR1brlbF+HRYd5qfK4HZdDIz7R3bjXDJUs5h
z55wxhsmIHsnCVapLvbUPYqP87+iBREbwmbt6Cpgnry306CFKhK2QHp1CcHMnjt+
5gptWhfjTAIhJYxF0yQeYq+v6+JXVtJHStWuU85UOCMZCBuEYRdUKSAH3ekp5vM=
=m0Im
-----END PGP SIGNATURE-----

--Sig_/J8+9bCvxNqDJdWP24ThGi_w--
