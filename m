Return-Path: <Marc.Dietrich@ap.physik.uni-giessen.de>
Received: from merkurneu.hrz.uni-giessen.de (merkurneu.hrz.uni-giessen.de
	[134.176.2.3]) by ozlabs.org (Postfix) with ESMTP id 528862BDB5
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 01:08:08 +1100 (EST)
From: Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
To: Christian <evilninja@gmx.net>
Date: Tue, 4 Jan 2005 14:23:33 +0100
References: <41D9FB86.1060407@gmx.net>
In-Reply-To: <41D9FB86.1060407@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200501041423.34061.marc.dietrich@ap.physik.uni-giessen.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hallo Christian,

thanks for your info. I was also a little confused by all these configs and 
images ...

So you are using netboot and it seems that when having a root-fs via nfs _no_ 
disk driver is initialized even if it is compiled in (acording to your 
config). Funny, didn't know that.

Sebastian just send me a mail with his bootlog, and later also some zImage url 
I hope. He is running a 2.6.8 kernel and his kernel (scsi: sym2 2.1.18j) 
seems to detect the hard disk but fails later due to the same scsi timeouts. 
Luckily, he managed to install 2 IDE disks...

Greetings

Marc

Am Dienstag, 4. Januar 2005 03:12 schrieben Sie:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> > anymore. but i'm building PReP kernel everyday, results and a config-file
> > is here:
> >
> > http://www.nerdbynature.de/bits/sheep/latest-kernel/
>
> sorry, it should read:
>
> http://www.nerdbynature.de/bits/hal/daily/
>
> > yes, i'll upload working zImage.prep + .config here:
> >
> > http://www.nerdbynature.de/bits/sheep/prep/
>
> and: http://www.nerdbynature.de/bits/hal/daily/results/
>
> >>>How does your boot.log looks like?
>
> will show up in http://www.nerdbynature.de/bits/hal/daily/boot/
>
> sorry for the confusion,
> Christian.
> - --
> BOFH excuse #57:
>
> Groundskeepers stole the root password
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.5 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>
> iD8DBQFB2fuGC/PVm5+NVoYRAiCxAKC8B1L+FVw/5CoG3y7IpFVxpqzrgACfVSK7
> gXQcGiHCfHg3vEabXHtaZaU=
> =2cwH
> -----END PGP SIGNATURE-----
