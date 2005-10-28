Return-Path: <msuresh@gamebox.net>
Received: from smtp-out.hotpop.com (smtp-out.hotpop.com [38.113.3.61])
	by ozlabs.org (Postfix) with ESMTP id ABC1868572
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 17:42:42 +1000 (EST)
Received: from gamebox.net (kubrick.hotpop.com [38.113.3.105])
	by smtp-out.hotpop.com (Postfix) with SMTP id 940051BA287A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 06:56:22 +0000 (UTC)
Received: from [192.168.0.222] (dsl-Chn-static-055.252.247.61.touchtelindia.net
	[61.247.252.55])
	by smtp-1.hotpop.com (Postfix) with ESMTP id AB7571A01EB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 06:55:10 +0000 (UTC)
Message-ID: <4361CC7B.7080304@gamebox.net>
Date: Fri, 28 Oct 2005 12:30:11 +0530
From: Suresh Chandra Mannava <msuresh@gamebox.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: SMP Design
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
I am working on a symmetric multiprocessing(SMP) based board design.  
Now,  I am into feasibility analysis.
Here are my queries
What qualifies a CPU to be capable of SMP?
       Hardware cache coherency
       test-and-set, compare-and-swap or load-link/ store-conditional 
instructions.
       Unique Id(read this in Intel MP specs) Is it required for 
powerpc-smp?
       CPU-local interrupt controller (intel specific) Is it required 
for powerpc-smp
       OpenPIC, interrupt routing
 
what are the other points that support SMP for a CPU. I read that ppc 
603 won't support pure SMP.

I am searching for the "considerations for SMP design using powerpc 
processors"
please provide pointers for the same.

Can I find any reference design for SMP boards? I am interested 
architecture part, interrupt routing and OpenPIC stuff.
I find it hard to find information on SMP board design.

Waiting for your response.

Thanks and Regards,
Suresh Chandra Mannava.
