Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (imap.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1756E67A6D
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 11:58:09 +1000 (EST)
Message-ID: <4253422D.5050606@gmx.net>
Date: Wed, 06 Apr 2005 03:58:05 +0200
From: Christian <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <20050328232355.GA1982@pegasos>
	<20050331142813.GH25923@smtp.west.cox.net>
	<20050331184549.GA28069@pegasos> <4251D5BA.5080905@gmx.net>
	<20050405053930.GD4604@pegasos>
	<20050405143802.GS25923@smtp.west.cox.net>
	<42533FA1.1070001@gmx.net>
In-Reply-To: <42533FA1.1070001@gmx.net>
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

Christian wrote:
> i booted vanilla 2.6.11.6 with noresidual (and "nopresidual" too, as Sven
> sugggested), but the scsi errors did not went away :(

um, no, worse that that: the scsi error kicks in for sym0:0:0:

sym0:0:0: DEVICE RESET operation started.
(...then it would continue until sym0:15:0, see [1])

then the machine locked up completely, not even SYSRQ works any more.
that happened when booting with "noresidual" and even with PREP_RESIDUAL=n
(in the .config).

thanks,
Christian.

[1] http://nerdbynature.de/bits/hal/2.6.11-rc5/dmesg
- --
BOFH excuse #48:

bad ether in the cables
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCU0ItC/PVm5+NVoYRAnVMAJ9L1eQLopn6ckMUkC+lNVnwsoKUCACfa2Tj
zqXc3jjKeiXpdYuih+wlZqs=
=GRwp
-----END PGP SIGNATURE-----
