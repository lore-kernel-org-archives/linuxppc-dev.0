Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22206DDE09
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jul 2007 01:19:10 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IDMAE-0001mc-Uc
	for linuxppc-embedded@ozlabs.org; Tue, 24 Jul 2007 08:19:06 -0700
Message-ID: <11765478.post@talk.nabble.com>
Date: Tue, 24 Jul 2007 08:19:06 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Interrupts on xilinx ml403
In-Reply-To: <fa686aa40707200812w3427c12dwd10b08c8433af2fc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <11708607.post@talk.nabble.com>
	<fa686aa40707200812w3427c12dwd10b08c8433af2fc@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Grant,

   Thanks for the suggestion. I will fix that and see what the EDK will
generate.

Best Regards

Mirek



Grant Likely-2 wrote:
> 
> On 7/20/07, Mirek23 <miroslaw.dach@psi.ch> wrote:
>> Does it mean that DIP Switches do not use INTC interrupt controller?
>> How to handle the DIP Switches interrupt?
>> Does the Interrupt handler routine have to acknowledge the interrupt from
>> Dip Switches?
> 
> It probably means that the GPIO irq out line is not hooked up to your
> INTC in the system.mhs file.
> 
> g.
> 
> -- 
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Interrupts-on-xilinx-ml403-tf4117226.html#a11765478
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
