Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3CC8DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Nov 2007 21:43:10 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IpLtj-0000vL-TH
	for linuxppc-embedded@ozlabs.org; Tue, 06 Nov 2007 02:43:07 -0800
Message-ID: <13604115.post@talk.nabble.com>
Date: Tue, 6 Nov 2007 02:43:07 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: what is difference between interrupt context and process context?
In-Reply-To: <80bb1bc60711012311v772a509di616e9190d7be391a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <80bb1bc60711012311v772a509di616e9190d7be391a@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Interrupt context mean that there will not be scheduling taking place untill
and unless that task ends while in the process context every task gets the
CPU time 



Barisa Kisku-2 wrote:
> 
> Hi,
> 
> What is difference between interrupt context and process
> context.Fromhardware(register context) view
> how they are different.In linux-2.6 interrupt stack is separate from
> kernel
> stack.How interrupt stack pointer
> is retrieved?How is the implementation in freescale ppc/powerpc.
> 
> please comment.
> 
> thanks in advance.
> 
> Barisa Kisku
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

-- 
View this message in context: http://www.nabble.com/what-is-difference-between-interrupt-context-and-process-context--tf4735753.html#a13604115
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
