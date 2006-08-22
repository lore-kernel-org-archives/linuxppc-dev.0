Return-Path: <Marc.Howard@kla-tencor.com>
Received: from ca1mail04.kla-tencor.com (mailout04.kla-tencor.com
	[192.146.1.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7D7567C3C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 04:44:32 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Deactivate serial console?
Date: Tue, 22 Aug 2006 10:46:57 -0700
Message-ID: <91B22F93A880FA48879475E134D6F0BE02EEA435@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@kla-tencor.com>
To: "Lee Revell" <rlrevell@joe-job.com>, "ppc" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"stty -F /dev/console 0" or the equivalent in code does the trick for me
but it might be implementation dependent.

Marc W. Howard

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+marc.howard=3Dkla-tencor.com@ozlabs.or
g [mailto:linuxppc-embedded-bounces+marc.howard=3Dkla->
tencor.com@ozlabs.org] On Behalf Of Lee Revell
> Sent: Tuesday, August 22, 2006 9:19 AM
> To: ppc
> Subject: Deactivate serial console?
>=20
> We're developing a PPC440 based system for a customer who=20
> requires that
> it be possible to disable/enable the serial console without a reboot.
> Is this possible without hacking the kernel?
>=20
> Lee
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
