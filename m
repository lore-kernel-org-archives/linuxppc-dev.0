Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 79AB8DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 12:56:47 +1100 (EST)
Received: from outbound6-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound6-sin-R.bigfish.com (Postfix) with ESMTP id 706451092768
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 01:47:16 +0000 (UTC)
Received: from mail173-sin-R.bigfish.com (unknown [10.3.40.3])
	by outbound6-sin.bigfish.com (Postfix) with ESMTP id 5F81D1A8004E
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 01:47:16 +0000 (UTC)
Received: from mail173-sin (localhost.localdomain [127.0.0.1])
	by mail173-sin-R.bigfish.com (Postfix) with ESMTP id 807C517A028D
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 01:56:15 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail173-sin.bigfish.com (Postfix) with ESMTP id 12B9B1528050
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 01:56:15 +0000 (UTC)
Received: from unknown-38-66.xilinx.com
	([149.199.38.66] helo=xsj-smtp1.xilinx.com
	ident=[U2FsdGVkX191Cdg8/OZTrqPzNzxasCd7FeHOyPanaOM=])
	by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <wolfgang.reissnegger@xilinx.com>) id 1Is7Uh-0005FH-Pk
	for linuxppc-dev@ozlabs.org; Tue, 13 Nov 2007 17:56:43 -0800
Date: Tue, 13 Nov 2007 17:56:42 -0800
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Xilinx Linux git server available
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <20071114015615.12B9B1528050@mail173-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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

Hope to hear from you soon  :-) 

Thanks,
   Wolfgang
