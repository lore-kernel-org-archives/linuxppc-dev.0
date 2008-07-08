Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RAMDISK: ran out of compressed data
Date: Tue, 8 Jul 2008 15:54:06 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D702B63C3B@corpexc01.corp.networkrobots.com>
In-Reply-To: <48730FFA.1070805@coritel.it>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D702B63AD3@corpexc01.corp.networkrobots.com>
	<48730FFA.1070805@coritel.it>
From: "Siva Prasad" <sprasad@bivio.net>
To: "Marco Stornelli" <marco.stornelli@coritel.it>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The same ramdisk works fine for 2.6.15 kernel. We are just upgrading to
a new version, and would like to get that ramdisk to work on the new one
as well.

Can you please elaborate on what you mean by compression format. Mine
currently use the standard .gz extension/compression.

Thanks
Siva


Siva Prasad ha scritto:
> Hi,
>=20
> I am getting the following error when I tried to boot with ramdisk.
Any
> specific reason or clue why this is happening?
>=20
> RAMDISK: Compressed image found at block 0
> RAMDISK: ran out of compressed data
> invalid compressed format (err=3D1)
>=20
> I am running into this on 8641D runing 2.6.24-rc6 kernel. My .config
> around block area are...
>=20
> CONFIG_BLK_DEV=3Dy
> # CONFIG_BLK_DEV_FD is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=3Dy
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> CONFIG_BLK_DEV_RAM=3Dy
> CONFIG_BLK_DEV_RAM_COUNT=3D16
> CONFIG_BLK_DEV_RAM_SIZE=3D49152
> CONFIG_BLK_DEV_RAM_BLOCKSIZE=3D1024
>=20
> Thanks
> Siva
>=20


I think it's not a kernel problem but a problem related with the=20
compression method instead. Check out how you are compressing the
ramdisk.

--=20
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
