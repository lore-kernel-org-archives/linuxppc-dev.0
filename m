Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BC1492BDF2
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Nov 2004 01:06:57 +1100 (EST)
Message-ID: <418A35ED.3090400@gmx.net>
Date: Thu, 04 Nov 2004 15:00:13 +0100
From: evilninja <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <4189888E.5070906@vision.caltech.edu>
In-Reply-To: <4189888E.5070906@vision.caltech.edu>
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
> After some research I found that to load a module on the 2.6 kernel one

yes, http://www.linux.org.uk/~davej/docs/post-halloween-2.6.txt is a good
start for 2.4 -> 2.6 upgrades.

> So I compile and install module-init-tools, but I get the same error.
> Does anyone know what's going on?

hm, are you sure the new "insmod" and "modprobe" are the *right* ones?
the PATH  variable will help here or try to specify the exact path on the
cmd line. here i have:

evil@prinz:~$ /sbin/modprobe -V
module-init-tools version 3.1-pre6
vil@prinz:~$ file /sbin/modprobe*
/sbin/modprobe:           ELF 32-bit LSB executable, Intel 80386, [...]
/sbin/modprobe.Lmodutils: symbolic link to `insmod'
/sbin/modprobe.modutils:  symbolic link to `insmod.modutils'

Christian.
- --
BOFH excuse #391:

We already sent around a notice about that.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBijXsC/PVm5+NVoYRAkspAJ9v5khRZVwpPxsmTL/v5tYKUUkrDgCg2np7
85mBGkq+rCRLwO7DJMNjoQA=
=xfHv
-----END PGP SIGNATURE-----
