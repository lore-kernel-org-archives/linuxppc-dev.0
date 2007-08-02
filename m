Return-Path: <jwilliams@itee.uq.edu.au>
Received: from gum.itee.uq.edu.au (gum.itee.uq.edu.au [130.102.66.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A5127DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Aug 2007 10:21:57 +1000 (EST)
Received: from filter2.itee.uq.edu.au (filter2.itee.uq.edu.au [130.102.66.22])
	by gum.itee.uq.edu.au (8.13.1/8.13.1) with ESMTP id l72Ns0Q1019925
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Aug 2007 09:54:01 +1000
Received: from [130.102.67.75] (g613-9373.itee.uq.edu.au [130.102.67.75])
	by filter2.itee.uq.edu.au (8.13.1/8.13.1) with ESMTP id l72Nrxop021873
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Aug 2007 09:53:59 +1000
Message-ID: <46B26E97.3040706@itee.uq.edu.au>
Date: Fri, 03 Aug 2007 09:53:59 +1000
From: John Williams <jwilliams@itee.uq.edu.au>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: suspend/resume (Xilinx V4)
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Any comments on the status/feasibility of suspend/resume for LinuxPPC on 
Xilinx devices?

The only suspend-related traffic I see here in the last 12 months is for 
the lite5200b board.

Any guesstimates of level of difficulty for such a task on Xilinx 
PPC405?  The core lite5200b patchset didn't look too hairy (just a 
modest bit of ASM :), but there would also be Xilinx device driver hooks 
to consider.

Also, are there kernel revision dependencies here?  Project is currently 
on an MVL 2.6.10 tree - but have seen mention of 2.6.17 (?) being 
earliest with PPC suspend/resume capability.

All info appreciated.  Thanks,

John
