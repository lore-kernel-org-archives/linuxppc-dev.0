Message-ID: <3E224E9F.C78B7823@xilinx.com>
Date: Sun, 12 Jan 2003 21:29:03 -0800
From: "Peter Ryser" <Peter.Ryser@xilinx.com>
MIME-Version: 1.0
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@sdrct.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Virtex II Pro FPGA and Linux
References: <B164B53F5BD6D511888D009027732E1A4D14B6@ntserver.act.domain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Xilinx is and has been working very closely with MontaVista to port Linux to
Virtex-II Pro. The following peripherals are implemented and are available today
in the linuxppc_2_4_devel tree:
- Uart 16450/16550
- IIC
- TFT LCD display
- touchscreen
- 10/100 Mbit Ethernet
- GPIO
- Sytem ACE CF controller (booting and CompactFlash card/IBM MicroDrive access)
- PS/2 for mouse and keyboard

Please note that all these peripherals are implemented in soft logic as part of
the FPGA. PCI will be available in the next few weeks.
We have booted Linux on various boards: ML300, AFX Virtex-II Pro cards, and the
Insight 2VP4/7 boards. The ML300 with its TFT display also runs X11.

ppcboot has been ported before to Virtex-II Pro. The port was pretty straight
forward but has never been published. We are currently looking into whether it
makes sense to integrate support for the ML300 board into "The U-Boot".
For booting Virtex-II Pro based boards my favourite boot method is with System
ACE CF. That's a companion chip that configures FPGA(s), boots the software
(Linux kernel), and later on allows you to use the attached CompactFlash
card/MicroDrive as the root file system.

More infos is available from the locations below.

- Peter, Xilinx Systems Engineering

Some links:

Boards
---------
- ML300 board: http://www.xilinx.com/ml300
- AFX boards:
http://www.xilinx.com/xlnx/xil_prodcat_product.jsp?iLanguageID=1&iCountryID=1&title=protoboards_protoboards_page#Virtex2ProPrototype

Press Releases, Publications and Talks
------------------------------------------------
- Press release: MontaVista Linux on ML300 (16 Dec):
http://www.xilinx.com/prs_rls/silicon_vir/02184ml300.htm
- Press release: MontaVista and Xilinx (7 Jul):
http://www.xilinx.com/prs_rls/partners/02103monte_vista.htm
- Linux Journal: Embedded System a la Carte (1 Aug):
http://www.linuxdevices.com/articles/AT4160697622.html
- SVLUG: Linux on Programmable Hardware (2 Oct):
http://www.svlug.org/prev/2002/Linux_on_programmable_hw.ppt (22MB!)

Other
-------
- System ACE CF: http://www.xilinx.com/isp/systemace/systemacecf.htm
- MontaVista: http://www.mvista.com



Rudolf Ladyzhenskii wrote:

> Hi, all
>
> Did anyone tried to port ppcboot and/or Linux to those chips? (they containg
> up to 4 PPC cores).
>
> Also any links regarding Linux and those FPGAs are appreciated. I am looking
> on including one of those in the new design and want to hear opinions.
>
> Thanks,
>
> /************************/
> Rudolf Ladyzhenskii
> Senior Design Engineer
> SDR Communications Technologies
> ph.  +61 3 8080 8215
> fax. +61 3 9672 8800
> Level 9, 341 Queen Street,
> Melbourne, 3000
> Australia
> e-mail: rudolf.ladyzhenskii@sdrct.com
> /***********************/
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
