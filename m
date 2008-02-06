Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 95E14DDECC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Feb 2008 09:52:55 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so887496anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 06 Feb 2008 14:52:51 -0800 (PST)
Message-ID: <fa686aa40802061452i78838bb0g87c99d76509c866e@mail.gmail.com>
Date: Wed, 6 Feb 2008 15:52:51 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kevin Holland" <khollan@daktronics.com>
Subject: Re: System Clock runaway on Xilinx platform
In-Reply-To: <1202337576.20550.6.camel@kevin-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <15312437.post@talk.nabble.com>
	<fa686aa40802061229w3c6ae051kec18d1d25ad1da4@mail.gmail.com>
	<1202337576.20550.6.camel@kevin-laptop>
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

On 2/6/08, Kevin Holland <khollan@daktronics.com> wrote:
> I load with the zImage.elf, so my xparameters are set like this:
>
> #define XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ 300000000
> #define XPAR_CORE_CLOCK_FREQ_HZ XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ
>
> I took readings every 5 min over a 15 min period and it seems to be
> increasing by approximately 50 sec every 5 mins.

Hmm; 5 min == 300 seconds
300 - 50 == 250 seconds

300/250 = 1.2

So, timebase_period_ns is set 1.2 times faster than the actual period.
 Can you confirm that the EDK frequency is actually correct?  Are you
*sure* that the CPU is running at 300MHz.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
