Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.248])
	by ozlabs.org (Postfix) with ESMTP id 5DC54DE089
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jan 2008 02:24:17 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so206121agc.0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 09 Jan 2008 07:24:16 -0800 (PST)
Message-ID: <fa686aa40801090724s60ecc812ub65f87d5a5bf57a0@mail.gmail.com>
Date: Wed, 9 Jan 2008 08:24:15 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Joachim Meyer" <Jogi95@web.de>
Subject: Re: Linux for ml310
In-Reply-To: <524013725@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <524013725@web.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/9/08, Joachim Meyer <Jogi95@web.de> wrote:
> Hi
>
http://git.secretlab.ca/git/gitweb.cgi?p=linux-2.6-virtex.git;a=snapshot;h=d7ed933b578d9c4dec0e23a5a6f78c464b31c47c;sf=tbz2
> Is this a complete Kernel? I don't really understand this whole git-tree stuff.
> then i copied the arch/ppc/configs/ml300_defconfig to .config.

Hint: this does the same thing,
$ ARCH=ppc make ml300_defconfig

> I used an edk9.1 with linux_2_6 as OS for the ppc405_0,  0x10000000 for memory size, 100000000 for uart16550 bus clock freq and set the target directory. Under connected_periphs where: RS232_Uart, SPI_EEPROM, PCI32_BRIDGE, SysACE_CompactFlash and opb_intc_0.
> At Software I pressed the "Generate Libaries and BSPs" Button and copied the generated xparameters.h to linux-2.6-virtex/arch/ppc/platforms/4xx/xparameters.

you want to copy xparameter_ml???.h to arch/ppc/platform/4xx/xparameters_ml300.h

Do not replace xparameter.h; it's a wrapper around the real xparams
file and it defines things that Linux needs.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
