Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E2A09DE204
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 16:01:02 +1100 (EST)
Date: Wed, 31 Jan 2007 08:01:00 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
Subject: Re: cpm_uart: WARNING: no UART devices found
Message-ID: <20070131080100.7b521527@localhost.localdomain>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E5F5EB8@aquib01a>
References: <F1F6EC0C8B75034F9E3A79FC85122E8E5F5EB8@aquib01a>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_9lKLRDThc+f.vAn.dZ_.RVb;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_9lKLRDThc+f.vAn.dZ_.RVb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jan 2007 09:30:49 +0100
DI BACCO ANTONIO - technolabs wrote:

> My board has an MPC880 and it is named TL880 with a linux 2.6.19, I
> copied kernel configurations from the very similar board mpc885ads.
> I filled in platform data in file TL880_setup.c but I see that
> function TL880_fixup_uart_pdata is never called and, as a
> consequence, I see the message cpm_uart: WARNING: no UART devices
> found. Also I receive message: IP-Config: No network devices
> available.=20

You seem to miss the board ppc_sys_identify_by_name() (or alike) call - so =
BOARD_CHIP_NAME is=20
not defined for your board in BSP file. There is no other way to properly i=
dentify SoC with 8xx...
--
Sincerely, Vitaly

--Sig_9lKLRDThc+f.vAn.dZ_.RVb
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFwCKMuOg9JvQhSEsRAuVhAJ4l/ZnfvxlyXX8oqqmup72d8Wm6CQCfZnkk
A80x5wEozP50hgL5jGGYf98=
=fBi2
-----END PGP SIGNATURE-----

--Sig_9lKLRDThc+f.vAn.dZ_.RVb--
