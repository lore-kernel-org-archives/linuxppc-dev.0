Return-Path: <sfr@canb.auug.org.au>
Received: from calzone.tip.net.au (calzone.tip.net.au
 [IPv6:2402:b800:7003:1::15])
 by ozlabs.org (Postfix) with ESMTP id 3C805B6F8C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2011 12:13:22 +1100 (EST)
Date: Wed, 2 Nov 2011 12:13:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <gregkh@suse.de>
Subject: Re: Regression: patch
 " hvc_console: display printk messages on console." causing infinite loop
 with 3.2-rc0 + Xen.
Message-Id: <20111102121309.4dbb0d2ac90d2879130820dd@canb.auug.org.au>
In-Reply-To: <20111027054806.GA1377@suse.de>
References: <20111027053007.GA32765@phenom.dumpdata.com>
 <20111027054806.GA1377@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__2_Nov_2011_12_13_09_+1100_lsOPgMWQm04RXl/E"
Cc: xen-devel@lists.xensource.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Rusty Russell <rusty@rustcorp.com.au>, miche@google.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Linus <torvalds@linux-foundation.org>, Anton Blanchard <anton@samba.org>,
 Amit Shah <amit.shah@redhat.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__2_Nov_2011_12_13_09_+1100_lsOPgMWQm04RXl/E
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Thu, 27 Oct 2011 07:48:06 +0200 Greg KH <gregkh@suse.de> wrote:
>
> On Thu, Oct 27, 2011 at 01:30:08AM -0400, Konrad Rzeszutek Wilk wrote:
> > Hey Miche.
> >=20
> > The git commit 361162459f62dc0826b82c9690a741a940f457f0:
> >=20
> >     hvc_console: display printk messages on console.
> >=20
> > is causing an infinite loop when booting Linux under Xen, as so:
>=20
> Ick, not good, thanks for letting us know.

Indeed. I am wondering why it was put in a tree and sent to Linus without
any Acks or even being replied to by anyone.  It appeared in the tty tree
between Oct 14 and Oct 25 (while I was unfortunately on vacation).  If
anyone had tried to boot this on any PowerPC server, it would have been
immediately obvious (as it was when I booted Linus' tree last night).

And the original author expressed doubts as to his understanding of how
it should all work anyway.

Just a little more care, please.

I would vote for reverting the original and having it resubmitted with
corrections at some later date.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__2_Nov_2011_12_13_09_+1100_lsOPgMWQm04RXl/E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOsJklAAoJEECxmPOUX5FE9UYP/2GMqOVKG+lC9uiq85ulDaGJ
rIfH6kGOwyMER5NpeTdJM4XaOnJwVKum0R4vA1F/Uz4JpO7CtWZjc8+bOYyGHLtV
uVc1Hf8dv8hLmy0YEFuVE+SvuacI70txycM9Uv6eGEYvCwh/c1BkOZk2/kb27vK2
zkDQ24l7BblWIm3fE31xPgtH8X2mmmHrMpdbq1fmOxz83Xa3IS82yksD0/fGjDNn
54RLMtxXwe4bdIRiDhUxLSqJT3UKmXZRiI24SwzSNzC//rIxxe9M39CaxWHCdWXL
0PCEbzE2EQof7aWypkDVJmOHYQGNg2uxdP7ZxeNZNkGR7scblvxHxtq906/xG53N
uVg6e6qS8CwjHPMlQl6WSRTBEXReMDKffeAQ9aACEvQAHtFW1HVqDOLSU1lS45vy
Y9LRGMB8WqvsLw35MaY74/yidnD60Zgl2pDN5KL2RTfh1wgEGh5YilunXvCxaD8l
J8hHXpFtG0n1r/pfsq876AGmNEnOF1IdfFmrsa8ZnUnCKNgGAuw7cUem8X8t7k8y
U1KM6Qu0cWdaCVMcvAP3bcfKlYYgYnclDxH/jXtjgFJlujb3ZZ5Yj4IHaq3mDS2I
A1qWnbU3FvI5ck5C81gEUqoL0Zp5EeN7g9wDLGVLKPO3f/HH7sMONlAL8nmBhyna
YbsmYz14IPXe4mZ02U2c
=/vwG
-----END PGP SIGNATURE-----

--Signature=_Wed__2_Nov_2011_12_13_09_+1100_lsOPgMWQm04RXl/E--
