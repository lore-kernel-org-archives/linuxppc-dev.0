Return-Path: <haokexin@gmail.com>
Received: from mail-qc0-x22e.google.com (mail-qc0-x22e.google.com
 [IPv6:2607:f8b0:400d:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06A4A1A0631
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 12:02:39 +1100 (AEDT)
Received: by mail-qc0-f174.google.com with SMTP id s11so33225203qcv.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Feb 2015 17:02:36 -0800 (PST)
Date: Tue, 3 Feb 2015 09:02:30 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 01/15] PCI: introduce pci_device_to_OF_node() for
 !CONFIG_OF
Message-ID: <20150203010230.GA28170@pek-khao-d1.corp.ad.wrs.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-2-git-send-email-haokexin@gmail.com>
 <1422844101.11325.4.camel@ellerman.id.au>
 <CAErSpo7B3yDQiD0XA9nBxb4tFW0BktT0EZ3HCZENOYQqMy0m_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
In-Reply-To: <CAErSpo7B3yDQiD0XA9nBxb4tFW0BktT0EZ3HCZENOYQqMy0m_Q@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 09:47:57AM -0600, Bjorn Helgaas wrote:
> I think it makes more sense to merge this along with the other 14
> patches that remove the #ifdefs (at least, I assume that's what they
> do; I haven't seen them).
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> But please edit the subject line so it is capitalized consistently
> with the rest of the history.  And it'd be nice if the changelog were
> a complete sentence all by itself, e.g.,
>=20
>     PCI: Add pci_device_to_OF_node() stub for !CONFIG_OF
>=20
>     Add a stub for pci_device_to_OF_node() so drivers don't need to use
>     #ifdef CONFIG_OF around calls to it.

Will update. Thanks Bjorn.

Kevin

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU0B4mAAoJEJNY7TDerrFxhFsH/iR0SsCZ6DK6wrj8AE+Qb1yH
yO4nPpZkoZzLMociB6IP9WmOAyQbGKy9IN2Sz8XO7DlB1ZRVYHqyWw1zyKmK9VDk
Ja2j4srmqlhlm1vClCgfjxYEqnI9r2V8QR2mjwf5fVjDf76PXbdsDObMiN2aEJT1
N7he2z+v9zrnw/1ELmBcZK0kHfPwINfdh4W6jWHEymrCFtciQ4W9vKuFE5OvYmWC
jBYrT6i3ccvMmuXLgoxTGJkc3uL1lRn8tl9cZN6WcYiPG5DkY6a1r3E9kGJ3dbkK
Hsirbkzep80nSbrtHi75/zE6uXxN8XhawSYcA/wDX1OW4wLwJ2hsIS0I+xwTV8s=
=fM4q
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
