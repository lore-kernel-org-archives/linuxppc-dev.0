Return-Path: <dja@axtens.net>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 042A61A0050
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 09:12:06 +1000 (AEST)
Received: by pdjm12 with SMTP id m12so59906844pdj.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2015 16:12:03 -0700 (PDT)
Message-ID: <1433286663.438.10.camel@axtens.net>
Subject: Re: [PATCH v1 1/9]powerpc/powernv: Data structure and macros
 definition
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephane
 Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>, Sukadev
 Bhattiprolu <sukadev@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Date: Wed, 03 Jun 2015 09:11:03 +1000
In-Reply-To: <1433260778-26497-2-git-send-email-maddy@linux.vnet.ibm.com>
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-2-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-RMMA6L+JJYdjf5nx53Wy"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-RMMA6L+JJYdjf5nx53Wy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */

I'm not certain about this, but I _think_ this is supposed to be version
2 only:
http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/CO=
PYING#n9


> +/*
> + * Device tree parser code detect nest pmu support
> + * and create new nest pmus. This structure will
> + * hold the pmu functions and attrs for each nest pmu and
> + * will be referenced at the time of pmu registering.
> + */

The first sentence of that comment is unclear: I think your trying to
say "Device tree parser code detects nest pmu support and registers new
nest pmus"? Also s/registering/registration/.

> +struct nest_pmu {
> +	struct pmu pmu;
> +	const struct attribute_group *attr_groups[4];
> +};
> +

Regards,
Daniel Axtens

--=-RMMA6L+JJYdjf5nx53Wy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVbjgSAAoJEPC3R3P2I92FPmYP/AmKY/jCb3A4sA47iTrNMAPH
m6+HdzGfABdruV/20vGl3nCCzOLEVcnj5Iz20xUQg2Pba6YKCTddCUXSYDTOPvd/
7/b5CtUG+iVMzw5H1UpqZTgsl8whiu7bkYsoDM5bgGY4l5obI9716oP40HNvZWvR
muaeCPYv0GMXYCi01wofIcEnRgs6sPK8APtAky6vanI/Qg3CP/zZtgCmZOmbRqNw
O9tMgr9WKkOaHkecjcgYAFRWcfoj8YoaG2m7izJaJONeYciOxZUU2X5FMApQP+mE
jRu/bwelqusIPm04lySZkCa1Uinoam4w+//t9hbSRLUtE9SnWEvRTnleO+Ps0RkA
ntHN8ozUmqyNtULRHGHSsbVQ5HAUH1RgnAWki9ZCbJaTyYzalehEHyTb/D+fUPmJ
fDvJSIKrwQSrEAhHF5z8KxcVrQmkmuNtrbqdY1G+AN8SUpTSYthCzhjrSATcQaIS
mbfxt32k6xsqUORdg248FTl5W3+P86ZU9sBEtVg/U2/YOaEVHsoT6h3N3OkMY0Qx
JBHhG+0qJe/1RoBlEsm7w4lRFjdZGUU30XHXKx/GJl3ltgTVYl4okdG2Hj4Ur8Rs
LUUTq+e8bhROpIS7bD5vzgReyT5czU309PKqfg2qTTaHI00s8SnJ8YUjHV0OshLm
AJkiZRTFjYa1ay4DypCu
=5cMf
-----END PGP SIGNATURE-----

--=-RMMA6L+JJYdjf5nx53Wy--
