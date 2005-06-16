Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 7503C67B86
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2005 19:25:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 16 Jun 2005 11:20:26 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B3A@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: "Dustin Lang" <dalang@cs.ubc.ca>,
	"Eugene Surovegin" <ebs@ebshome.net>
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

Ok here we go, I'm sorry for that but it's always the most enormous =
thing that are missed.
Indeed, I do return a EBUSY when more that one process has opened the =
device driver.
So I'm really sorry for disturbing you for that since I had many other =
real hard problems in Linux
before.=20
I think I'm getting Linux-parano=EF...
Tks again and have a nice day



-------- Message d'origine--------
De: Dustin Lang [mailto:dalang@cs.ubc.ca]
Date: mer. 15/06/2005 20:16
=C0: Eugene Surovegin
Cc: Garcia J=E9r=E9mie; linuxppc-dev@ozlabs.org
Objet : Re: RE : Error while opennig device file
=20

Also - does it work from the command line?  Do both mknod commands work? =

When you "ls -l /dev/test{1,2}" , what do you get?  What happens when =
you=20
"cat /dev/test1" or "echo > /dev/test1" ?

Cheers,
dstn.


>> I'm sorry but this is a "copy to mail" error.
>> Here is the right code:
>>
>> ret_val =3D system("mknod -m 777 /dev/test1 c 122 1");
>> ret_val =3D system("mknod -m 777 /dev/test2 c 122 2");
>>
>> file_desc1 =3D open("/dev/test1", O_RDWR);
>> file_desc2 =3D open("/dev/test2", O_RDWR);
