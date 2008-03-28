Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 24C0EDDFAE
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 03:06:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Patch: FW:Xilinx: BSP: Updated ML405 to match
	hardwareusedfortesting
Date: Fri, 28 Mar 2008 09:06:12 -0700
In-Reply-To: <068401c890d0$294e3e10$ad289e86@LPSC0173W>
References: <052801c88f37$3b51f7e0$ad289e86@LPSC0173W><fa686aa40803260601j6e7f507fpe4d31c7c462fce5e@mail.gmail.com><066b01c890c0$17d9a800$ad289e86@LPSC0173W>
	<068401c890d0$294e3e10$ad289e86@LPSC0173W>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>,
	<linuxppc-dev@ozlabs.org>
Message-Id: <20080328160614.6018DF68050@mail116-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: =
linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of
Guillaume Dargaud
> Sent: Friday, March 28, 2008 5:35 AM
> To: linuxppc-dev@ozlabs.org
> Subject: Re: Patch: FW:Xilinx: BSP: Updated ML405 to match
hardwareusedfortesting
>=20
> I should add that I've tried several things:
> - compile the Xilinx kernel as indicated in my previous message.
> - compile it with just the xparameters_ml*.h files added

This should work.

> - copy all the files from the BSP into the (Xilinx) kernel tree
> - directly generate the BSP into the (Xilinx) kernel tree

Neither of these will work.

> For instance, the last one still gives me:
> .config:117:warning: trying to assign nonexistent symbol
WANT_EARLY_SERIAL
> .config:122:warning: trying to assign nonexistent symbol BUBINGA
> .config:123:warning: trying to assign nonexistent symbol CPCI405
> .config:124:warning: trying to assign nonexistent symbol EP405
> .config:127:warning: trying to assign nonexistent symbol SYCAMORE
> .config:129:warning: trying to assign nonexistent symbol XILINX_ML300
> .config:130:warning: trying to assign nonexistent symbol XILINX_XUPV2P
> .config:131:warning: trying to assign nonexistent symbol XILINX_ML403
> .config:132:warning: trying to assign nonexistent symbol XILINX_ML405
> .config:133:warning: trying to assign nonexistent symbol XILINX_ML41x
> .config:138:warning: trying to assign nonexistent symbol
XILINX_EMBED_CONFIG
> .config:139:warning: trying to assign nonexistent symbol EMBEDDEDBOOT
> .config:140:warning: trying to assign nonexistent symbol PPC4xx_DMA
> .config:142:warning: trying to assign nonexistent symbol UART0_TTYS0
> .config:143:warning: trying to assign nonexistent symbol UART0_TTYS1
> .config:149:warning: trying to assign nonexistent symbol PC_KEYBOARD
> .config:759:warning: trying to assign nonexistent symbol
SERIAL_TEXT_DEBUG
> .config:772:warning: trying to assign nonexistent symbol XILINX_OCP
> .config:773:warning: trying to assign nonexistent symbol XILINX_ML40x

Did you check out the head of the tree?

> Two more things:
>=20
> $ make ARCH=3Dppc ml405_defconfig
> cp  .config
> cp: missing destination file operand after `.config'
> Try `cp --help' for more information.
> make: *** [ml405_defconfig] Error 1

I'd suggest starting over with a fresh tree.
1) Copy the xparameters file, overwriting the appropriate xparameters
file in the git tree.
2) make ARCH=3Dppc ml405_defconfig
3) make ARCH=3Dppc all

> And on the page
http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex
> which I've been studying closely, I also tried the Secret Lab
repository:
> $ git clone git://git.secretlab.ca/git/linux-2.6-virtex.git
> Initialized empty Git repository in
> /home/guinevere/buildroot/linux-2.6-virtex/.git/
> fatal: The remote end hung up unexpectedly
> fetch-pack from 'git://git.secretlab.ca/git/linux-2.6-virtex.git'
failed.

I know Grant has been having problems with the secretlab git server
recently.

Steve
