Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id B85DCB6F9F
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 19:21:44 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 20954-06 for <linuxppc-dev@ozlabs.org>;
 Mon, 25 Jun 2012 10:21:42 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH] bluetooth: opcode field of sent commands is little endian.
Date: Mon, 25 Jun 2012 10:20:25 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6F62@saturn3.aculab.com>
In-Reply-To: <1340609570.5461.50.camel@thor.local>
From: "David Laight" <David.Laight@ACULAB.COM>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
 "Marcel Holtmann" <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@intel.com>,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > > Fine with me, though FWIW that not only doesn't use
> > > __constant_cpu_to_le16() but actually swaps the non-constant =
value.
> >=20
> > Don't see what point you are trying to make here. Swapping the value
> > from the actual command structure is always fine with me.
>=20
> The point is that the result of swapping a constant value is just
> another constant value, whereas the fix in mainline swaps a value from
> memory. Not a big deal.

Surely, but surely, the definition of cpu_to_le16() uses
gcc 'magic' to determine that the argument is a constant
and then automatically selects the 'constant' form.

	David
