Return-Path: <DaveLiu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 33C1667B54
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Aug 2006 13:49:45 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k7G3nigH013038 for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Aug 2006 20:49:44 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7G3ngM5021001
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Aug 2006 22:49:43 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: hoe to define CPM_MAP_ADDR ?
Date: Wed, 16 Aug 2006 11:49:41 +0800
Message-ID: <995B09A8299C2C44B59866F6391D26350CD82F@zch01exm21.fsl.freescale.net>
In-Reply-To: <20060816032420.3004.qmail@web15110.mail.cnb.yahoo.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "jie han" <jiehanca@yahoo.com.cn>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

You can refer to the other board config file like MPC8260ADS.

-Dave

> I am trying to take a working embedded linux system from=20
> kernel 2.4 to=20
> 2.6. The hardware is a custom board using a MPC8270 processor.
> The working system uses u-boot 1.1.1 with linux kernel 2.4.24.
> I am using the same u-boot and I am trying to port linux=20
> kernel 2.6.15=20
> to our platform. I just wonder hwo to define CPM_MAP_ADDR to=20
> my config file
> at /arch/ppc/platforms/olt8270.h,thsi show file context as follow
>=20
> #ifndef __OLT8270_PLATFORM
> #define __OLT8270_PLATFORM
>=20
> //#define CPM_MAP_ADDR  ((uint)0xf0000000)
> #define IMAP_ADDR  ((uint)0xf0000000)
>=20
> #define BOOTROM_RESTART_ADDR ((uint)0xfff00100)
>=20
> /* For our show_cpuinfo hooks. */
> #define CPUINFO_VENDOR  "Ocean Broadband Ltd"
> #define CPUINFO_MACHINE  "OLT8270 PowerPC"
>=20
> /* A Board Information structure that is given to a program when
>  * prom starts it up.
>  */
> typedef struct bd_info {
>  unsigned long bi_memstart; /* Memory start address */
>  unsigned long
>  bi_memsize;     /* Memory (end) size in bytes */
>  unsigned long bi_flashstart; /* start of FLASH memory */
>  unsigned long bi_flashsize; /* size  of FLASH memory */
>  unsigned long bi_flashoffset; /* reserved area for startup monitor */
>     unsigned long   bi_sramstart;   /* start of SRAM memory */
>     unsigned long   bi_sramsize;    /* size of SRAM memory */
>=20
>  unsigned long bi_immr;     /* IMMR when called from boot rom */
>=20
>  unsigned long   bi_bootflags;   /* boot flag (for Lynx OS) */
>=20
>  unsigned long   bi_ip_addr;     /* IP Address */
>  unsigned char   bi_enetaddr[6]; /* Ethernet address */
>  unsigned short  bi_ethspeed;    /* Ethernet speed in Mbps */
>=20
>  unsigned long bi_intfreq;     /* Internal Freq, in Hz */
>  unsigned long bi_busfreq;     /* Bus Freq, in MHz */
>  unsigned long bi_cpmfreq;     /* CPM Freq, in MHz */
>  unsigned long bi_brgfreq;     /* BRG Freq, in MHz */
>  unsigned long bi_sccfreq;     /* SCC Freq, in MHz
>  */
>  unsigned long bi_vco;      /* VCO Out from PLL */
>  unsigned long bi_baudrate; /* Default console baud rate */
> } bd_t;
>=20
> extern bd_t m8xx_board_info;
>=20
> #endif  /* __OLT8270_PLATFORM */
>=20
>=20
>=20
> Sincerely,
>=20
>=20
> Jie
>=20
> ________________________________
>=20
> Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone=20
> calls. Great rates starting at 1=A2/min.=20
> <http://us.rd.yahoo.com/mail_us/taglines/postman7/*http://us.r
> d.yahoo.com/evt=3D39666/*http://messenger.yahoo.com>=20
>=20
