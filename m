Subject: RE: Compile Linux-2.4.2 with MTD support for walnut 405gp
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Date: Tue, 10 Apr 2001 09:43:34 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E310A9132@kolkrabbi.flaga.is>
From: =?gb2312?B?S6iicmkgRGF2qKplc3Nvbg==?= <kd@flaga.is>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You can only have one mapping compiled into the kernel at one time, so
drop one of the:

CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_SC520CDP=y

or compile them as modules.

Also why do you need

CONFIG_MTD_ROM=y

Hope this helps,

K.D.

> -----Original Message-----
> From: °×ÑÞ¸» [mailto:byfmail@yeah.net]
> Sent: 10. apr¨ªl 2001 08:36
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Compile Linux-2.4.2 with MTD support for walnut 405gp
>
>
>
> I compile it success, but when booting show me
>
> "Physically mapped flash: Found no CFI device at location zero"
>
> followed is my config for mtd.
>
> #
> # Memory Technology Devices (MTD)
> #
> CONFIG_MTD=y
> CONFIG_MTD_DEBUG=y
> CONFIG_MTD_DEBUG_VERBOSE=3
> # CONFIG_MTD_DOC1000 is not set
> # CONFIG_MTD_DOC2000 is not set
> # CONFIG_MTD_DOC2001 is not set
> # CONFIG_MTD_DOCPROBE is not set
> # CONFIG_MTD_PMC551 is not set
> # CONFIG_MTD_SLRAM is not set
> # CONFIG_MTD_RAM is not set
> CONFIG_MTD_ROM=y
> # CONFIG_MTD_MTDRAM is not set
> CONFIG_MTD_CFI=y
> # CONFIG_MTD_CFI_VIRTUAL_ER is not set
> CONFIG_MTD_CFI_ADV_OPTIONS=y
> CONFIG_MTD_CFI_NOSWAP=y
> # CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
> # CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
> # CONFIG_MTD_CFI_LART_BIT_SWAP is not set
> CONFIG_MTD_CFI_GEOMETRY=y
> # CONFIG_MTD_CFI_B1 is not set
> # CONFIG_MTD_CFI_B2 is not set
> CONFIG_MTD_CFI_B4=y
> # CONFIG_MTD_CFI_I1 is not set
> CONFIG_MTD_CFI_I2=y
> # CONFIG_MTD_CFI_I4 is not set
> # CONFIG_MTD_CFI_INTELEXT is not set
> CONFIG_MTD_CFI_AMDSTD=y
> # CONFIG_MTD_AMDSTD is not set
> # CONFIG_MTD_SHARP is not set
> CONFIG_MTD_PHYSMAP=y
> CONFIG_MTD_PHYSMAP_START=fff80000
> CONFIG_MTD_PHYSMAP_LEN=7ffff
> CONFIG_MTD_PHYSMAP_BUSWIDTH=4
> # CONFIG_MTD_NORA is not set
> # CONFIG_MTD_PNC2000 is not set
> # CONFIG_MTD_RPXLITE is not set
> CONFIG_MTD_SC520CDP=y
> # CONFIG_MTD_SBC_MEDIAGX is not set
> # CONFIG_MTD_ELAN_104NC is not set
> # CONFIG_MTD_SA1100 is not set
> # CONFIG_MTD_DC21285 is not set
> # CONFIG_MTD_IQ80310 is not set
> # CONFIG_MTD_CSTM_CFI_JEDEC is not set
> # CONFIG_MTD_CFI_FLAGADM is not set
> CONFIG_MTD_JEDEC=y
> # CONFIG_MTD_MIXMEM is not set
> # CONFIG_MTD_OCTAGON is not set
> # CONFIG_MTD_VMAX is not set
> # CONFIG_MTD_ARM is not set
> # CONFIG_MTD_NAND is not set
> # CONFIG_MTD_NAND_SPIA is not set
> # CONFIG_MTD_CHAR is not set
> # CONFIG_MTD_BLOCK is not set
> # CONFIG_MTD_BLOCK_RO is not set
> # CONFIG_FTL is not set
> # CONFIG_NFTL is not set
>
> How should I configure for it?
> Thank you!
>
> 				byf
>             byfmail@yeah.net
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
