Return-Path: <jaap.dejong@nedap.com>
Received: from smtp2.nedap.com (smtp2.nedap.com [213.160.213.92])
	by ozlabs.org (Postfix) with ESMTP id 1B39267BDF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 18:29:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Running Linux on Avnet's FX12 Evaluation Board
Date: Fri, 29 Sep 2006 10:17:29 +0200
Message-ID: <6915D0AE8B9047438F320B466AE30FDD9BA5A4@nvs0003.nedap.local>
From: "Jaap de Jong" <jaap.dejong@nedap.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I had to declare the ddr_sdram as plb_ddr instead of opb_ddr...

Jaap


-----Original Message-----
Hello,

I am trying to run a Linuxppc 2.4 kernel (20051021) on an IBM Powerpc
405, I have compiled it according to the instructions on
http://www.itee.uq.edu.au/~jwilliams/mblaze-uclinux/uclinux_powerpc/#lin
uxppc-2,
I load it into the ram using the Xilinx Microprocessor Debug (XMD)
Engine and try to run it, but it seems to have some trouble with the
memory:
