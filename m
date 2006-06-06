Return-Path: <DaveLiu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 9564B67A44
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Jun 2006 11:39:45 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k561oEtN001369
	for <linuxppc-embedded@ozlabs.org>; Mon, 5 Jun 2006 18:50:15 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k561deTp018653
	for <linuxppc-embedded@ozlabs.org>; Mon, 5 Jun 2006 20:39:42 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673026FD940@zch01exm40.ap.freescale.net>
From: Liu Dave-r63238 <DaveLiu@freescale.com>
To: "'Naru Sundar'" <nsundar@fulcrummicro.com>, linuxppc-embedded@ozlabs.org
Subject: RE: ppc85xx DMA
Date: Tue, 6 Jun 2006 09:39:29 +0800 
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Dear sirs,
> 
> I am trying to add a DMA transfer component to my driver on 
> linux 2.6 on a ppc 8541.  Following the steps listed in the 
> reference manual, I write the SAR, SATR, DAR, DATR and BCR 
> registers before cycling the bit in the MR register to start 
> the transfer.
> 
What is the DMA transfer mode? Is direct or chaining mode?

> The SR register though indicates a transfer error as soon as 
> I write the DAR register.  Clearly I've gotten the mapping 
> wrong. I know what the address I am trying to write to in 
> kernel space is, what is unclear is what address the DAR 
> register is expecting.
> 

Did you ioremap the DMA register space?
The DAR register need the physical address

Dave
