Return-Path: <markc@mail.com>
Received: from relay03.roc.ny.frontiernet.net (relay03.roc.ny.frontiernet.net
	[66.133.131.36]) by ozlabs.org (Postfix) with ESMTP id 471FF2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Oct 2004 00:11:38 +1000 (EST)
Message-ID: <00c201c4bb66$0139ccc0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "soar.wu" <soar.wu@utstar.com>, <linuxppc-embedded@ozlabs.org>
References: <PCEFKKAFFIJFPILJEMCHAEAJCGAA.soar.wu@utstar.com>
Date: Tue, 26 Oct 2004 10:13:24 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Cc: 
Subject: Re: Help!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Clear Day>Firstly we will write data to the HPI,
>then read data from the HPI to the SDRAM(this SDRAM is connected with
60x-BUS).
>The last we will read the data from the SDRAM to compare the data which is
write >to HPI.

Can you show the entire source for hpi_ul_memcpy_dsp2h()?

Also, you say 'HPI' - are connected to a T.I. DSP?  Which one?

Mark Chambers
