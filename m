Return-Path: <alan.casey5@mail.dcu.ie>
Received: from hawk.dcu.ie (mail.dcu.ie [136.206.1.5])
	by ozlabs.org (Postfix) with ESMTP id 79E46DE287
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 01:39:53 +1000 (EST)
Date: Thu, 3 Jul 2008 16:18:56 +0100
Message-ID: <4858FDD100015AFE@hawk.dcu.ie>
From: "Alan Casey" <alan.casey5@mail.dcu.ie>
Subject: Linux issues on Xilinx XUPV2P board
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Cc: alan.casey5@mail.dcu.ie
Reply-To: alan.casey5@mail.dcu.ie
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

  I have tried running the Linux 2.6.24 and Linux 2.6.26 kernels from   
  git.xilinx.com on the Xilinx XUPV2P board but have run into a few probl=
ems.

  Cross-compiler i use to compile applications was built using Crosstools=

and
  based on gcc 3.3.4. I use Xilinx EDK 7.1 for integrating hardware perip=
herals
  onto the board.

  The problems i've seen are:

  (i) gettimeofday software function returns time of 0 all the time.

  (ii) The Linux 2.6.24 kernel's Xilinx Framebuffer driver and/or the Xil=
inx

       PLB TFT Controller IP block (plb_tft_cntlr_ref_v1_00_d) does not a=
ppear

       to centre the display on a VGA screen properly(vertically offset).=


  (iii) 64-bit write/read access to peripheral integrated onto the Xilinx=


        Virtex-II Pro FPGA either causes a system crash or only lower par=
t

        of 32-bit data to be written (i.e. lower part of 64-bit data appe=
ars
        to be mirrored on the upper and lower 32-bits of the system bus).=

        However, 32-bit write/read access to the peripheral passes as wel=
l
        as 64-bit write/read access to the SDRAM memory address space.
        Peripheral interface has been verified to be IBM PLB compliant 
        via IBM bus functional model simulations. 

   (iv) The Linux 2.6.26 Xilinx Framebuffer driver on the Xilinx XUPV2P b=
oard

        does not appear to be working - nothing displayed to screen/conso=
le

        not switching to framebuffer device on bootup. 

   Just wondering if anybody has seen these issues before and know how to=

   resolve them?

   Any info. appreciated,
   Regards,
   Alan.

  
