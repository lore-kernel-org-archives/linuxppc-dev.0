Return-Path: <michael@ellerman.id.au>
Subject: Re: application needs fast access to physical memory
From: Michael Ellerman <michael@ellerman.id.au>
To: steven.lin@teradyne.com
In-Reply-To: <OFEB1252DC.D653C7C7-ON882577DE.0078DABB-862577DE.00792502@notes.teradyne.com>
References: <OFEB1252DC.D653C7C7-ON882577DE.0078DABB-862577DE.00792502@notes.teradyne.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-RDW1osiPoH6TkmM8GwYX"
Date: Thu, 18 Nov 2010 23:24:22 +1100
Message-ID: <1290083062.22575.9.camel@concordia>
Mime-Version: 1.0
Cc: Steven_Lin@notes.teradyne.com, linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-RDW1osiPoH6TkmM8GwYX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-11-17 at 16:03 -0600, steven.lin@teradyne.com wrote:
> My application needs a fast way to access a specific physical DDR
> memory region. The application runs on an MPC8548 PowerPC which has an
> MMU. I've tried two approaches that are typical for Linux, mmap() and
> using a kernel module that implements read()/write() into this region
> and I'm finding that performance is very slow for both. It's a couple
> orders of magnitude slower than, for example, copying a large buffer
> from one place in the application's virtual memory to another place in
> the application's virtual memory.

The mmap() version should basically run at "full speed", at least once
you've faulted the address range in.

This specific DDR region isn't specifically slow is it ? :)

cheers

--=-RDW1osiPoH6TkmM8GwYX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzlGvYACgkQdSjSd0sB4dJzkgCfZEiWFy/9AMpXECJTw9r/7JSR
3bAAoMecPYt9rv2p3zIVJY/S9/7jq6EZ
=bcNT
-----END PGP SIGNATURE-----

--=-RDW1osiPoH6TkmM8GwYX--
