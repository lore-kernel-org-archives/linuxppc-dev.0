Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 3893267A6B
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 11:47:22 +1000 (EST)
Message-ID: <42533FA1.1070001@gmx.net>
Date: Wed, 06 Apr 2005 03:47:13 +0200
From: Christian <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <20050328232355.GA1982@pegasos>
	<20050331142813.GH25923@smtp.west.cox.net>
	<20050331184549.GA28069@pegasos> <4251D5BA.5080905@gmx.net>
	<20050405053930.GD4604@pegasos>
	<20050405143802.GS25923@smtp.west.cox.net>
In-Reply-To: <20050405143802.GS25923@smtp.west.cox.net>
Content-Type: text/plain; charset=UTF-8
Cc: Tom Rini <trini@kernel.crashing.org>
Subject: Re: PREP sym53c8xx sym53c8xx brokeness due to
 2.6.9-rc1-bk1	introduced residual data patch ...
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

Tom Rini wrote:
> Can either of you verify that say 2.6.11.6 w/ "noresidual" on the
> command-line works?  Thanks.

i booted vanilla 2.6.11.6 with noresidual (and "nopresidual" too, as Sven
sugggested), but the scsi errors did not went away :(

on a side note, and perhaps totally unrelated: i always have
PROC_PREPRESIDUAL=y in my .config, but i never had /proc/residual as
promised from the help text.

thanks,
Christian.
- --
BOFH excuse #48:

bad ether in the cables
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCUz+hC/PVm5+NVoYRApdaAJ90DeNHRdmHHnQBflMrWyFt1/vO6gCfQixe
jLOm8vmTPNR+xKR9K6Yk9Fs=
=GnEk
-----END PGP SIGNATURE-----
