Return-Path: <kari.davidsson@marel.is>
Received: from mail.marel.com (mail.marel.is [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 26154DDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Dec 2007 20:58:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: LPC burst accesses
Date: Tue, 11 Dec 2007 09:46:57 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB027FEAA7@is-hdq-exchange.marel.net>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.is>
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

I am in the process of optimizing read accesses to an FPGA in one of our =
custom mpc5200b boards.

I have attempted to do this in two ways, i.e.

1) With the the general SDMA task. Also used by the AC97 audio codec =
driver.
2) Trought the SCLPC fifo offered in relation with the LP bus.

The documentation on freescales site is somehow very vague and even =
though they talk about
read burst accesses they also seem not to be able to guarantee under =
what conditions
burst accesses are generated/not generated. The result that I am seeing =
is that even though=20
that the DMA task and fifo is working as expected (transfering data from =
the FPGA to memory/fifo)
burst reads are _never_ generated (short burst/long burst).

Is there any enlightened soul out there that might shed a litle light on =
this issue or point me into=20
the right direction where I can find more concrete documentation.

I am using linux 2.6.23 as base for these experiments.

rg
kd
