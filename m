Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id F0A382BF0C
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Nov 2004 10:31:14 +1100 (EST)
Message-ID: <418ABBBD.4090808@gmx.net>
Date: Fri, 05 Nov 2004 00:31:09 +0100
From: evilninja <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
References: <4189888E.5070906@vision.caltech.edu> <418A35ED.3090400@gmx.net>
	<418A827C.9090802@vision.caltech.edu>
In-Reply-To: <418A827C.9090802@vision.caltech.edu>
Content-Type: text/plain; charset=UTF-8
Subject: Re: problem with insmod
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Arrigo Benedetti schrieb:
> Yes, I have verified that. Someone has also suggested to check that the
> compiler used to build the module
> is the same compiler that build the kernel. The Makefile is below and it
> seems that this is also ok.

hm, i've built module-init-tools from source too once, but now your distro
of choice will hat a binary package too, i think. maybe you can go with
this package to get modules in 2.6 running and can go on with the
debugging of your compiled version afterwards. (maybe "strace modprobe"
will help here...? or is the module itself not proper compiled? (make
mrproper)...)

just my 2¢....
- --
BOFH excuse #16:

somebody was calculating pi on the server
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBiru9C/PVm5+NVoYRAkJsAJ9JytrFkpj/y7CA8Y8fuL6oQ5WwZgCeKTsm
YW2BlwyhM24P/L4YG9uAvd0=
=BrnQ
-----END PGP SIGNATURE-----
