Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id B87E0DDED8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 05:10:19 +1000 (EST)
To: Domen Puncer <domen.puncer@telargo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: pata_mpc52xx - no interrupts when using bestcomm/dma?
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 27 Aug 2007 11:44:54 +0200."
	<20070827094454.GQ13994@moe.telargo.com>
Date: Mon, 27 Aug 2007 21:10:16 +0200
Sender: wd@denx.de
Message-Id: <20070827191017.0856024044@gemini.denx.de>
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

In message <20070827094454.GQ13994@moe.telargo.com> you wrote:
> 
> The problem is that I can't seem to get any interrupts
> (not ata, not bestcomm task), when setting up MWDMA/UDMA mode.

First, please check the errata. There are some issues in this area  -
one  involves the ATA controller not handling automatic pause for DMA
transfers (controller will corrupt FIFO data when there is  any  sig-
nificant transfer load - system freezes, kernel crashes); another one
is erratum 158: "ATA interrupt is not affected by FIFO errors."

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Conscious is when you are aware of something, and conscience is  when
you wish you weren't.
