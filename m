Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id EA7B467B2A
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 01:51:53 +1000 (EST)
Message-ID: <4256A88C.70101@gmx.net>
Date: Fri, 08 Apr 2005 17:51:40 +0200
From: Christian <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <20050328232355.GA1982@pegasos>	<20050331142813.GH25923@smtp.west.cox.net>	<20050331184549.GA28069@pegasos>
	<4251D5BA.5080905@gmx.net>	<20050405053930.GD4604@pegasos>	<20050405143802.GS25923@smtp.west.cox.net>	<42533FA1.1070001@gmx.net>	<20050406185049.GF3396@smtp.west.cox.net>	<33467.82.10.231.190.1112960162.squirrel@82.10.231.190>
	<20050408145431.GY3396@smtp.west.cox.net>
In-Reply-To: <20050408145431.GY3396@smtp.west.cox.net>
Content-Type: text/plain; charset=UTF-8
Cc: Tom Rini <trini@kernel.crashing.org>
Subject: Re: PREP sym53c8xx sym53c8xx brokeness due
 to	2.6.9-rc1-bk1	introduced residual data patch ...
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
> 
> If this works, I'd like to see this get into 2.6.12.  Please re-send to
> akpm / this list.  Assuming it's just the above:
> Acked-by: Tom Rini <trini@kernel.crashing.org>

yes! i just applied Leigh's patch (thanks!) to a pristine 2.6.11.6 and my
PReP here booted fine:
  http://www.nerdbynature.de/bits/hal/2.6.11.6/leigh/

thank you,
Christian.
- --
BOFH excuse #284:

Electrons on a bender
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCVqiLC/PVm5+NVoYRAmsZAJ9PlBmKEi/lASAtY4xx+74FzBxxkQCggjoy
IBqhEVSNEgm7BhOVEJfBWY0=
=XgaG
-----END PGP SIGNATURE-----
