Return-Path: <Paul.Burton@imgtec.com>
Received: from imgpgp01.kl.imgtec.org (mailapp01.imgtec.com [195.59.15.196])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3syFjz1hPVzDvJn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2016 22:05:43 +1100 (AEDT)
From: Paul Burton <paul.burton@imgtec.com>
To: Andreas Schwab <schwab@linux-m68k.org>
CC: <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, Tejun Heo
 <tj@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, "Jiri
 Slaby" <jslaby@suse.cz>, Daniel Vetter <daniel.vetter@ffwll.ch>, "Ivan
 Delalande" <colona@arista.com>, Thierry Reding <treding@nvidia.com>,
 "Borislav Petkov" <bp@suse.de>, Jan Kara <jack@suse.com>, Petr Mladek
 <pmladek@suse.com>, <linux-kernel@vger.kernel.org>, Joe Perches
 <joe@perches.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Frank Rowand <frowand.list@gmail.com>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] console: Don't prefer first registered if DT specifies
 stdout-path
Date: Mon, 17 Oct 2016 11:33:55 +0100
Message-ID: <4033254.tBrl4yKcsP@np-p-burton>
In-Reply-To: <87bmyk88x5.fsf@linux-m68k.org>
References: <20160809125010.14150-1-paul.burton@imgtec.com>
 <20160809151937.26118-1-paul.burton@imgtec.com>
 <87bmyk88x5.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3065225.SPOVmq47Dl";
 micalg=pgp-sha256; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart3065225.SPOVmq47Dl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 16 October 2016 20:07:18 BST Andreas Schwab wrote:
> On Aug 09 2016, Paul Burton <paul.burton@imgtec.com> wrote:
> > Fix this by not automatically preferring the first registered console if
> > one is specified by the device tree. This allows consoles to be
> > registered but not enabled, and once the driver for the console selected
> > by stdout-path calls of_console_check() the driver will be added to the
> > list of preferred consoles before any other console has been enabled.
> > When that console is then registered via register_console() it will be
> > enabled as expected.
> 
> This breaks the console on PowerMac.  There is no output and it panics
> eventually.
> 
> Andreas.

Hi Andreas,

Could you share the device tree from your system?

Thanks,
    Paul
--nextPart3065225.SPOVmq47Dl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYBKkTAAoJEIIg2fppPBxl1oAP/RAIYEhMTK2tf/pX7/5z4Y4m
x2cl84qdY844A2UNXEP89g3CuqMaEefDBSU/8HKitoCl+Cu+bR2RKQPYBiiVNTnv
77tgOCK1J4IYwqZi0xT+QcmUwAGvJ69+HdiXorIgzPWzXqgAPBql75mOtQMoTXZy
XVdpHnW2GVwV5kRdEG0HalLjMvNTh6hLAMK2YDVdyuV0+Ox8XPPTXskmMqHb092m
ATVfilJ5x8AHQIA7EHuYA72lPLEFE8aokeO317EH3k0GL2cUDTh1/IqXYvrS2g/f
BMcAzkXujR53jp/8PGztyEWEzjToc7p2dapQ8dmqWId965D3CUdO9y279EdUUUmV
MvI2HLzX1joW5W6MMBH3ts1QZVrtHkb8cSoudSgbyhY5+TR3GCJ6li5e4FIduLFp
Ttl5YoNWHZdylSEXA6vY2ZKdzcAONz481tJIwaabEtbktPiTWrl95Vc+X+ejC7up
3/50FdPlpt31NuGaqNMiu2AOB2NIxRMazxDhrlf7ee3UEve0xsRy9UjJrl3lP1iQ
6sJhRUhaqBk92cvP/HV5HCWhRUcQmyicUMJB5JTYv0zELxJQSGtq9eXAgv7q+E5J
3jRTAIZ3chWxUona9nMiu5Q1jgyhDcmBKJatFGilcTzHi0fLijdOTMgq4woC+biW
Yr7i8EOdJDRYShgWsxKz
=hh/A
-----END PGP SIGNATURE-----

--nextPart3065225.SPOVmq47Dl--
