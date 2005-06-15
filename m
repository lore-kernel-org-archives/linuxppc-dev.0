Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id D8ED267B31
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2005 04:23:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 15 Jun 2005 20:22:06 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B37@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-dev@ozlabs.org
Subject: RE : RE : Error while opennig device file
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I give you all those infos tomorrow cause I'm from France and it's soon =
9:00pm, so I'm not at office.
Tks a lot for your help


-------- Message d'origine--------
De: Eugene Surovegin [mailto:ebs@ebshome.net]
Date: mer. 15/06/2005 20:00
=C0: Garcia J=E9r=E9mie
Cc: linuxppc-dev@ozlabs.org
Objet : Re: RE : Error while opennig device file
=20
On Wed, Jun 15, 2005 at 07:47:56PM +0200, Garcia J?r?mie wrote:
> I'm sorry but this is a "copy to mail" error. =20
> Here is the right code:
>=20
> ret_val =3D system("mknod -m 777 /dev/test1 c 122 1");
> ret_val =3D system("mknod -m 777 /dev/test2 c 122 2");
>=20
> file_desc1 =3D open("/dev/test1", O_RDWR);
> file_desc2 =3D open("/dev/test2", O_RDWR);
>=20
> Sorry again but I would have liked that it was so easy...lol

OK, how does open routine for your device look like?
What error do you get on second open?

--=20
Eugene
