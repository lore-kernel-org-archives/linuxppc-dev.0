Date: Tue, 17 Oct 2000 16:46:17 +0200
From: Claus Enneper <cl.en@gmx.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: Topi Kanerva <tkanerva@ees2.oulu.fi>
Subject: Re: IrDA on PowerBooks
Message-ID: <20001017164617.B369@olis.north.de>
References: <20001017015054.A16003@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
In-Reply-To: <20001017015054.A16003@ee.oulu.fi>; from tkanerva@ees2.oulu.fi on Tue, Oct 17, 2000 at 01:50:54 +0300
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Topi!

 >:=20
 >: Now, anyone who has succesfully got any IrDA devices to work with the
 >: PowerBook IrDA port? any suggestions?


don't know anything about the ericson, but as long as you followed
the IRDA-HOWTO, it should work right out of the box.
get the irda-utils src, or use debian's package.
and there is a gsmlib-rpm at linuxppc, which manage your sms (no GUI).
	I did't try that one, 'cause I use irda only for the palm.

# irattach /dev/ttyS1
# irmanager -d 1
and after that it's a matter of your userland app via /dev/ircomm0




		Claus

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature
Content-Disposition: inline


--4SFOXa2GPu3tIq4H--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
