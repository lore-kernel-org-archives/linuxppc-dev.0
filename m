Return-Path: <sbajaj@tsi-telsys.com>
Received: from exchange.tsi-telsys.com (unknown [205.230.130.11])
	by ozlabs.org (Postfix) with ESMTP id 72EEA67B37
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 06:19:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 8 Apr 2005 16:19:45 -0400
Message-ID: <0007F077BB3476449151699150E8FEA21A7B92@exchange.tsi-telsys.com>
From: "Sanjay Bajaj" <sbajaj@tsi-telsys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Error enabling CONFIG_PPC4XX_DMA in lk2.4.27-pre3?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi! Gurus,

I tried to enable DMA in lk2.4.27-pre3 and it fails with the error =
attached to the end of the mail. On further debugging, I found that =
though CONFIG_PPC4XX_DMA is included in the .config but the =
asm/ppc4xx_dma.h includes CONFIG_PPC4XX_EDMA, which includes all the =
constants reported undeclared in the error message. Out of curiosity, =
changed .._EDMA to .._DMA in asm/ppc4xx_dma.h and still had errors. Any =
help is appreciated.

Thanks,
Sanjay


*****

ppc4xx_dma.c: In function `ppc4xx_enable_dma':
ppc4xx_dma.c:116: error: `DMA_CS0' undeclared (first use in this =
function)
ppc4xx_dma.c:116: error: (Each undeclared identifier is reported only =
once
ppc4xx_dma.c:116: error: for each function it appears in.)
ppc4xx_dma.c:116: error: `DMA_TS0' undeclared (first use in this =
function)
ppc4xx_dma.c:116: error: `DMA_CH0_ERR' undeclared (first use in this =
function)
ppc4xx_dma.c:117: error: `DMA_CS1' undeclared (first use in this =
function)
ppc4xx_dma.c:117: error: `DMA_TS1' undeclared (first use in this =
function)
ppc4xx_dma.c:117: error: `DMA_CH1_ERR' undeclared (first use in this =
function)
ppc4xx_dma.c:118: error: `DMA_CS2' undeclared (first use in this =
function)
ppc4xx_dma.c:118: error: `DMA_TS2' undeclared (first use in this =
function)
ppc4xx_dma.c:118: error: `DMA_CH2_ERR' undeclared (first use in this =
function)
ppc4xx_dma.c:119: error: `DMA_CS3' undeclared (first use in this =
function)
ppc4xx_dma.c:119: error: `DMA_TS3' undeclared (first use in this =
function)
ppc4xx_dma.c:119: error: `DMA_CH3_ERR' undeclared (first use in this =
function)
ppc4xx_dma.c: In function `ppc4xx_init_dma_channel':
ppc4xx_dma.c:624: error: `SET_DMA_CONTROL' undeclared (first use in this =
function)
ppc4xx_dma.c:629: warning: implicit declaration of function =
`GET_DMA_POLARITY'
ppc4xx_dma.c: In function `ppc4xx_get_channel_config':
ppc4xx_dma.c:726: warning: implicit declaration of function =
`GET_DMA_PRIORITY'
ppc4xx_dma.c:738: error: structure has no member named `ch_enable'
ppc4xx_dma.c:738: warning: implicit declaration of function `GET_DMA_CH'
ppc4xx_dma.c:739: error: structure has no member named `ece_enable'
ppc4xx_dma.c:740: error: structure has no member named `tcd_disable'
ppc4xx_dma.c: In function `ppc4xx_set_channel_priority':
ppc4xx_dma.c:763: error: `PRIORITY_LOW' undeclared (first use in this =
function)
ppc4xx_dma.c:764: error: `PRIORITY_MID_LOW' undeclared (first use in =
this function)
ppc4xx_dma.c:765: error: `PRIORITY_MID_HIGH' undeclared (first use in =
this function)
ppc4xx_dma.c:765: error: `PRIORITY_HIGH' undeclared (first use in this =
function)
ppc4xx_dma.c:772: warning: implicit declaration of function =
`SET_DMA_PRIORITY'
