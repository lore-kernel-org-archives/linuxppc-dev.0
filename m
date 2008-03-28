Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7FD8DDDF5
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 23:35:15 +1100 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m2SCZAMn031489
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 13:35:10 +0100
Message-ID: <068401c890d0$294e3e10$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
References: <052801c88f37$3b51f7e0$ad289e86@LPSC0173W><fa686aa40803260601j6e7f507fpe4d31c7c462fce5e@mail.gmail.com>
	<066b01c890c0$17d9a800$ad289e86@LPSC0173W>
Subject: Re: Patch: FW:Xilinx: BSP: Updated ML405 to match hardware
	usedfortesting
Date: Fri, 28 Mar 2008 13:35:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I should add that I've tried several things:
- compile the Xilinx kernel as indicated in my previous message.
- compile it with just the xparameters_ml*.h files added
- copy all the files from the BSP into the (Xilinx) kernel tree
- directly generate the BSP into the (Xilinx) kernel tree

For instance, the last one still gives me:
.config:117:warning: trying to assign nonexistent symbol WANT_EARLY_SERIAL
.config:122:warning: trying to assign nonexistent symbol BUBINGA
.config:123:warning: trying to assign nonexistent symbol CPCI405
.config:124:warning: trying to assign nonexistent symbol EP405
.config:127:warning: trying to assign nonexistent symbol SYCAMORE
.config:129:warning: trying to assign nonexistent symbol XILINX_ML300
.config:130:warning: trying to assign nonexistent symbol XILINX_XUPV2P
.config:131:warning: trying to assign nonexistent symbol XILINX_ML403
.config:132:warning: trying to assign nonexistent symbol XILINX_ML405
.config:133:warning: trying to assign nonexistent symbol XILINX_ML41x
.config:138:warning: trying to assign nonexistent symbol XILINX_EMBED_CONFIG
.config:139:warning: trying to assign nonexistent symbol EMBEDDEDBOOT
.config:140:warning: trying to assign nonexistent symbol PPC4xx_DMA
.config:142:warning: trying to assign nonexistent symbol UART0_TTYS0
.config:143:warning: trying to assign nonexistent symbol UART0_TTYS1
.config:149:warning: trying to assign nonexistent symbol PC_KEYBOARD
.config:759:warning: trying to assign nonexistent symbol SERIAL_TEXT_DEBUG
.config:772:warning: trying to assign nonexistent symbol XILINX_OCP
.config:773:warning: trying to assign nonexistent symbol XILINX_ML40x


Two more things:

$ make ARCH=ppc ml405_defconfig
cp  .config
cp: missing destination file operand after `.config'
Try `cp --help' for more information.
make: *** [ml405_defconfig] Error 1


And on the page http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex
which I've been studying closely, I also tried the Secret Lab repository:
$ git clone git://git.secretlab.ca/git/linux-2.6-virtex.git
Initialized empty Git repository in 
/home/guinevere/buildroot/linux-2.6-virtex/.git/
fatal: The remote end hung up unexpectedly
fetch-pack from 'git://git.secretlab.ca/git/linux-2.6-virtex.git' failed.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
