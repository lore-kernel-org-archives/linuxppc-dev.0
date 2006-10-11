Return-Path: <rdcorle@yahoo.com>
Received: from web56309.mail.re3.yahoo.com (web56309.mail.re3.yahoo.com
	[216.252.110.233]) by ozlabs.org (Postfix) with SMTP id 9976067B1A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Oct 2006 06:46:33 +1000 (EST)
Message-ID: <20061011204632.80180.qmail@web56309.mail.re3.yahoo.com>
Date: Wed, 11 Oct 2006 13:46:31 -0700 (PDT)
From: robert corley <rdcorle@yahoo.com>
Subject: RE: plb_temac, ML403, linux 2.4.26, EDK 7.1
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ming;=0A=0AHere is what the EDK generates in this file:=0A=0AC:\EDK\project=
s\startup_network\ppc405_0\libsrc\linux_mvl31_v1_01_a\linux\arch\ppc\platfo=
rms\xilinx_ocp\xparameters_ml300.h=0A=0A<snip>=0A#define XPAR_XTEMAC_NUM_IN=
STANCES 1=0A#define XPAR_PLB_TEMAC_0_BASEADDR 0x60000000=0A#define XPAR_PLB=
_TEMAC_0_HIGHADDR 0x60003FFF=0A#define XPAR_PLB_TEMAC_0_DEVICE_ID 0=0A#defi=
ne XPAR_PLB_TEMAC_0_IPIF_RDFIFO_DEPTH 131072=0A#define XPAR_PLB_TEMAC_0_IPI=
F_WRFIFO_DEPTH 131072=0A#define XPAR_PLB_TEMAC_0_MAC_FIFO_DEPTH 64=0A#defin=
e XPAR_PLB_TEMAC_0_DMA_TYPE 3=0A#define XPAR_PLB_TEMAC_0_TEMAC_DCR_HOST 0=
=0A#define XPAR_PLB_TEMAC_0_INCLUDE_DRE 1=0A<snip>=0A=0A=0AWhich is fine.  =
However, the file in the linux distribution: linux_2_4_devel/drivers/net/xi=
linx_enet/adapter.c is looking for "XEMAC" instead of "XTEMAC" as above.=0A=
=0AAlso, when I look at the EDK project directory =0A=0A"C:\EDK\projects\st=
artup_network\ppc405_0\libsrc\linux_mvl31_v1_01_a\linux\drivers\net\"=0A=0A=
I see that it is empty.  Which means that nothing in the MVL tree will be o=
verwritten (specifically the adapter.c file, which uses the above defines).=
=0A=0ASo, it appears that the driver is not being properly insterted into t=
he tree as expected.  Would you agree?=0A=0A-R=0A=0A
