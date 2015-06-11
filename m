Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80E8C1A06DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 12:23:39 +1000 (AEST)
Received: from mail-pd0-x22e.google.com (mail-pd0-x22e.google.com
 [IPv6:2607:f8b0:400e:c02::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DD5DF1402B2
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 12:23:38 +1000 (AEST)
Received: by pdjn11 with SMTP id n11so48633591pdj.0
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 19:23:36 -0700 (PDT)
Message-ID: <1433989359.31423.28.camel@axtens.net>
Subject: Re: [PATCH V8 01/10] powerpc, perf: Drop the branch sample when
 'from' cannot be fetched
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Date: Thu, 11 Jun 2015 12:22:39 +1000
In-Reply-To: <5578274A.8080402@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433906475.3096.1.camel@axtens.net> <5578274A.8080402@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-XrSLTfcSSd6AIHVaW/CY"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-XrSLTfcSSd6AIHVaW/CY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2015-06-10 at 17:32 +0530, Anshuman Khandual wrote:
> On 06/10/2015 08:51 AM, Daniel Axtens wrote:
> > Hi Anshuman,
> >=20
> > Was there a cover letter for this series that I missed?
>=20
> This is the continuation (rebased and reworked) of the series
> posted at https://lkml.org/lkml/2014/5/5/153 (which is V6). I
> remember to have incremented the count for the re-send of the
> first four patches of the series to Peter Z for generic review
> which got pulled in last year. These patches here are the
> remaining powerpc part of the original series. Will list down
> the current changes as well next time around along with the new
> ones.
>=20
> >=20
> > On Mon, 2015-06-08 at 17:08 +0530, Anshuman Khandual wrote:
> >> BHRB is a rolling buffer. Hence we might end up in a situation where
> > Could you spell out what BHRB stands for?
>=20
> Branch History Rolling Buffer, would you like to have that in the
> commit message as well ?
Yes please.
>=20
> >=20
> >> we have read one target address but when we try to read the next entry
> >>  indicating the from address of the targe, the buffer just overflows.
> > target?
>=20
> Yeah its target address.
Ok, I was just trying to point out the spelling mistake above.
>=20
> >=20
> >> In this case, the captured from address will be zero which indicates
> >> the end of the buffer.
> >>
> > In what sort of situations would this occur? It seems like something we
> > would want to avoid if possible?
>=20
> Its not avoidable. During regular flow of branch recording, the HW would
> have written both the records correctly but then the new ones came in and
> we just happen to loose one of them causing this situation.
OK.

Regards,
Daniel

--=-XrSLTfcSSd6AIHVaW/CY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVePDvAAoJEPC3R3P2I92Fn6AP/1WUsoQmFO5dGZSw1sF9mcm8
fyXpgVSpT6qzFeixs5Des4XQdHbB7BWhLJxgXexL7Cgixt1GRnsWcyIkoXhaE2pN
E+BycJEtmVkqsEbTuD2vUXQIcuXqymYfeufMLiFloCDracpdpqoiEO139KIhAKKh
WpQCA9uTKOCNvgwhV2aAtKsma8z36YOKIQYK/zCAhppxWQ9mWsBf3MWQglpASQh7
YAlkhLPWBZk4VdtD9so8C/SpkWII63fkKVEIzW59w1eJ2OJu/hj8B7DOgjxFzdS9
FhmIgKs2w3OZaAaCe3S9RHorsRzZZzkqD1h4XAaFi53fZcoTv5UG65AeqMIA+X/8
9s2acmrDHuboLUqdXh6FyLzEFlXqkrBGkU766DQok8UoUdjm90YhtSkFu5HKfLc0
qwtVEyEvq2k7j8DlHT85pjE/fMxKw33Gcbl+ipy9zwxskelnpqUzAELGzaKSQyHO
wS3+jfGMgp8CWkh7oYeKaQPmJggAuabbx3PE537tJ2CK4uh5FkC7FnZ7mrzT3YuS
H+qTPjhe6KNdbh4yHOtAUVfV05m1zkWlmu5YYsSqZepI7E9QN5AjtouCpD3eudQ5
AzpwNiIhoxnbXmQPGsR1FQdOaLKPMH5b1sLkNgXE8AdAPoRwcQyAhN2PJxiIAvVB
bs0RkqSXsNrzsVTXnYvY
=iSMK
-----END PGP SIGNATURE-----

--=-XrSLTfcSSd6AIHVaW/CY--
