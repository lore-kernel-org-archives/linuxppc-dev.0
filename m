Return-Path: <nsundar@fulcrummicro.com>
Received: from smtp.fulcrummicro.com (smtp.fulcrummicro.com [66.59.247.212])
	by ozlabs.org (Postfix) with ESMTP id 0113C679E1
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Jun 2006 10:55:39 +1000 (EST)
Received: from lab3.internal.avlsi.com (lab3.internal.avlsi.com [10.0.0.79])
	by smtp.fulcrummicro.com (Postfix) with ESMTP id 5F38E2A2B2E
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Jun 2006 17:55:36 -0700 (PDT)
Received: (from nsundar@localhost)
	by lab3.internal.avlsi.com (8.13.6/8.12.8/Submit) id k560tZJN021139
	for linuxppc-embedded@ozlabs.org; Mon, 5 Jun 2006 17:55:35 -0700
Date: Mon, 5 Jun 2006 17:55:35 -0700
From: Naru Sundar <nsundar@fulcrummicro.com>
To: linuxppc-embedded@ozlabs.org
Subject: ppc85xx DMA
Message-ID: <20060606005535.GB18144@fulcrummicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear sirs,

I am trying to add a DMA transfer component to my driver on linux 2.6 on a
ppc 8541.  Following the steps listed in the reference manual, I write the
SAR, SATR, DAR, DATR and BCR registers before cycling the bit in the MR
register to start the transfer.

The SR register though indicates a transfer error as soon as I write the
DAR register.  Clearly I've gotten the mapping wrong. I know what the
address I am trying to write to in kernel space is, what is unclear is
what address the DAR register is expecting.

Any help would be appreciated

-naru
