Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 70096DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 12:38:27 +1100 (EST)
Date: Tue, 13 Nov 2007 17:38:21 -0800
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org,  uclinux-dev@uclinux.org
Subject: Xilinx Linux git server
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <20071114013823.1F8B61230055@mail175-blu.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm happy to announce that the Xilinx Linux Kernel git server is finally up and running and available to the public.

The Xilinx Linux Kernel is based on the mainline Linux Kernel from kernel.org and adds driver support for various Xilinx IP cores and Xilinx reference boards. It contains many (but not all) of the MicroBlaze contributions and enhancements from John Williams' PetaLogix Linux distribution and some PPC work from Grant Likely. It also contains contributions from Stephen Neuendorffer, Joachim Foerster and Brian Hill, to name a few.

The kernel includes drivers to support the following Xilinx IP cores:
  * EMAC, EMACLITE, TEMAC, LLTEMAC
  * UART, UARTLITE
  * SYSACE
  * SPI, GPIO, FB, GPIO, HWICAP, AC97

and support for the following boards:
  * ML40x, ML4x0
  * Spartan 3E 1600, XUPV2P

In a couple weeks we will be adding MicroBlaze v7 MMU support.

The kernel is licensed under the GPL version 2 and is provided AS IS. It is _not_ supported in any way or form by the Xilinx Support Center. If you call the Xilinx Support center, they will not be able to help you. For those interested in a supported Linux distribution, please contact one of the many partner companies at:

   http://www.xilinx.com/ise/embedded/epartners/listing.htm

Please, also keep in mind that the kernel is not actively being tested and will may set your house on fire.

The git URL for the Xilinx Linux Kernel sources is:

   git://git.xilinx.com/linux-2.6-xlnx.git

The Web front-end for this server can be found at:

   http://git.xilinx.com

At this time there are two branches available:
  * lin26-xlnx
    This branch is based on the latest stable kernel release (currently 2.6.23)
  * lin26-xlnx-rc
    This branch tracks the leading edge mainline (currently 2.6.24-rc2)

The git server also hosts a clone of Grant Likely's OF device tree generation tool with additions by Stephen Neuendorffer to support MicroBlaze systems. The git URL for this repository is:

   git://git.xilinx.com/gen-mhs-devtree.git

If you have suggestions or want to contribute to the Xilinx Linux Kernel, please send your feedback, patches or other contributions to:

   git _at_ xilinx.com

Hope to hear from you soon :-)

Thanks,
   Wolfgang
