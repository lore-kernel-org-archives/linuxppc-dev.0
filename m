Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 79572DDED2
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 03:43:03 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l86HgwbZ004038
	for <linuxppc-embedded@ozlabs.org>; Thu, 6 Sep 2007 13:42:58 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l86Hgv47685778
	for <linuxppc-embedded@ozlabs.org>; Thu, 6 Sep 2007 13:42:58 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l86HgvBM016766
	for <linuxppc-embedded@ozlabs.org>; Thu, 6 Sep 2007 13:42:57 -0400
Date: Thu, 6 Sep 2007 12:42:32 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "CHAVENT Paul" <Paul.CHAVENT@alyotech.fr>
Subject: Re: Support a new platform in arch/ppc or in arch/powerpc ?
Message-ID: <20070906124232.2e7bc969@zod.rchland.ibm.com>
In-Reply-To: <631F24C6E5322142A5BDEFA2E8518080297862@tls01.criltechnology.net>
References: <631F24C6E5322142A5BDEFA2E8518080297862@tls01.criltechnology.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 6 Sep 2007 18:53:54 +0200
"CHAVENT Paul" <Paul.CHAVENT@alyotech.fr> wrote:

> Good morning.
> 
> I would like to port a bsp (for the motorola MVME5500 sbc) to the current (2.6.22.6) kernel.
> 
> Should i implement it in arch/powerpc ?

Yes.  arch/ppc is bug fix only at this point.

> If i should do it in arch/powerpc, can i copy some code i need in arch/ppc ? For example, with kernel 2.6.18.1 i used arch/ppc/syslib/todc_time and arch/ppc/syslib/pci_auto, but perhaps i don't need it anymore ?

I'm not sure those will work well in arch/powerpc.  But obviously some
code porting is expected.

josh
