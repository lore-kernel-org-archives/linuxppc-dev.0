Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D9D75DDE42
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 12:02:40 +1000 (EST)
Date: Thu, 5 Apr 2007 12:02:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] allow vmsplice to work in 32-bit mode on ppc64
Message-Id: <20070405120253.0b0ee501.sfr@canb.auug.org.au>
In-Reply-To: <20070404172519.GZ11029@redhat.com>
References: <20070404172519.GZ11029@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__5_Apr_2007_12_02_53_+1000_9LKyofxMlXZB_VUX"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__5_Apr_2007_12_02_53_+1000_9LKyofxMlXZB_VUX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 4 Apr 2007 13:25:19 -0400 Don Zickus <dzickus@redhat.com> wrote:
>
> Trivial change to pass vmsplice arguments through the compat layer on
> pp64.
>
> Signed-off-by: Don Zickus <dzickus@redhat.com>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

Obviously noone uses vmsplice from 32bit processes on ppc64 :-)
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__5_Apr_2007_12_02_53_+1000_9LKyofxMlXZB_VUX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGFFjYFdBgD/zoJvwRAkR7AJ4+YRV8R+JXuE6lBZKPBa1rcXlI2ACdGOqK
4vFm79w+F6OPHElIdAVYuS4=
=l4Bp
-----END PGP SIGNATURE-----

--Signature=_Thu__5_Apr_2007_12_02_53_+1000_9LKyofxMlXZB_VUX--
