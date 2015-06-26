Return-Path: <jlinton@tributary.com>
Received: from relay05.mycloudmailbox.com (relay05.mycloudmailbox.com
 [199.244.76.202])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B987A1A03A4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2015 08:35:59 +1000 (AEST)
Message-ID: <558DD3C8.6000800@tributary.com>
Date: Fri, 26 Jun 2015 17:35:52 -0500
From: Jeremy Linton <jlinton@tributary.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Rob Herring <robherring2@gmail.com>, Jeremy Linton
 <lintonrjeremy@gmail.com>, Grant Likely <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Paul Mackerras
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: pSeries boot failure due to wrong interrupt controller
References: <CAEFTgiyHkf8ooYdWW0nTLcdraJ_L9FpLSVZa4KS3CcdpGWJxew@mail.gmail.com>	
 <CAL_JsqJqkUL8XyqR6yjg+-thj4YOQ6cUohGHHid71tdRFft7vw@mail.gmail.com>	
 <558D91C1.6030004@tributary.com>
 <1435355687.26815.8.camel@kernel.crashing.org>
In-Reply-To: <1435355687.26815.8.camel@kernel.crashing.org>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On 6/26/2015 4:54 PM, Benjamin Herrenschmidt wrote:
> Ah I missed that completely. From your discussion, it looks correct, I'll
> see if I can find a machine to test, however I think we dropped support for
> POWER3 so it might be non-trivial to do so.

	Thanks, the problem originally cropped up on a power4+, I was going to test
it on power5 too, but I don't have access anymore. I do have a power3 as well,
but I think that machine has other issues (the BUG_ON in the platform table
for starters).


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)

iQEcBAEBAgAGBQJVjdPIAAoJEL5i86xrzcy7KA0H+QHVe3IFy12DlgxP0kbbaDtr
D5JLqh9OHBxZohotRzQz5errCIBYGxIYy93P6S2NvQSKS1gqZFFrvdyIs0f3UYo0
izzRVh/Gf10p0d3MJDI0EYC7OlxlP4hJ8lZKU2PNFQvhLT4eE1i/XJAySJLJsSpG
WD9CiP5Flixm/ECBPbyeg9nnc5c+EM4xPhE6J3Zp5pX7gU0cieJb2rzhz/7/TsI1
6AYMOPC4JpL3aK5z4eKuVgzvuJ/MyCjHdwii0TpNBhhhyidq8PEDoH3Y61CIOszq
Uu5HAQoToqBZdKM7siiZY0LJVQVpJaze4zhjexqhGa/Ll0iquj3V13xZ5qjj1eA=
=oeSx
-----END PGP SIGNATURE-----
