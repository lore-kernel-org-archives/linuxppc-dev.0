Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 9E353B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 17:57:31 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 25654-03 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 08:57:19 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: book to learn ppc assembly and architecture
Date: Wed, 18 May 2011 08:56:13 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD3D@saturn3.aculab.com>
In-Reply-To: <BANLkTinuzAwxxMJ+BAYrrotH6an=wvZ3=Q@mail.gmail.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "kevin diggs" <diggskevin38@gmail.com>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
	s shaiju <sha_neb@hotmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > On Mon, 2011-05-16 at 16:37 +1000, Michael Neuling wrote:
> >> > what =A0is =A0the =A0best =A0book =A0to =A0learn =A0assembly =
=A0and architecture .
>=20
> Assuming you have a powerpc compiler available you can use the -S
> option to produce assembly listings.

With gcc add -fverbose-asm for more info.

For a general background, look at something much simpler than ppc,
even if you don't write/run any code.

	David
