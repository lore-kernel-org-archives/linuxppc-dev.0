Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by ozlabs.org (Postfix) with ESMTP id 4F394DE8C0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jul 2008 02:18:34 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so248519wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 09:18:33 -0700 (PDT)
Date: Fri, 18 Jul 2008 10:18:31 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Naresh Bhat <nareshgbhat@gmail.com>
Subject: Re: ml403_emb_ref_ppc_81.zip problem
Message-ID: <20080718161831.GB10317@secretlab.ca>
References: <cf9b3c760807180413w447535a7h35d8ce15c2c8e4e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cf9b3c760807180413w447535a7h35d8ce15c2c8e4e@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Please don't ask EDK-specific question on this mailing list.  This list
is for Linux on PowerPC.  Your question is strictly about using Xilinx's
proprietary toolchain.  You should go to Xilinx's website to look for
help.

g.

On Fri, Jul 18, 2008 at 04:43:14PM +0530, Naresh Bhat wrote:
> My problem is explained here...
> 
> While creating the new XPS project using Base system Builder:
> 
> 
> Step 1.
> 
> 
> 
> New Project->Base System builder Project-> Create a new XPS project using
> Base system Builder->Browse system.xps project from "ml403_emb_ref_ppc_81"
> directory and overite it.
> 
> 
> 
> Step 2.
> 
> I am selecting "I would like to create the new design"
> 
> and then
> 
> Board Vendor "Xilinx"
> 
> Board name "ML403"
> 
> Board version "1"
> 
> 
> 
> Step 3:
> 
> I just click "Next"
> 
> 
> 
> Step 4:
> 
> I am selecting the Processor Cloclk Frequency as "300Mhz"
> 
> 
> 
> Step 5: Configuring the IO interfaces
> 
> 
> 
> Here is my problem.
> 
> 
> 
> In RS232 UART I am having the only 2 option
> 
> 1. XPS_UARTLITE
> 
> 2. XPS_UART16550
> 
> 
> 
> If I use the same base system builder (ml403_emb_ref_ppc_81) with other
> version of the EDK tools (like 8.1iSP2, 9.2iSP2). and repeat the same steps
> I am able to see the options like
> 
> 1. OPB_UARTLITE
> 
> 2. OPB_UART16550
> 
> 3. PLB_UART16550
> 
> 
> 
> Do you have any idea on this Why it is not getting displayed on the
> EDK10.1iSP2 version?
> 
> 
> Thanks
> 
> Naresh Bhat

> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
