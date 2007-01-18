Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 8549ADDE08
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Jan 2007 17:28:01 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so94845ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 22:28:00 -0800 (PST)
Message-ID: <528646bc0701172227l132eebcbtc04f5fcb0c027fc3@mail.gmail.com>
Date: Wed, 17 Jan 2007 23:27:59 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Bernd Sowislo" <BSowislo@gmx.de>,
	"linuxppc-embedded list" <linuxppc-embedded@ozlabs.org>
Subject: Re: Fw: [Bugme-new] [Bug 7808] New: Xilinx ML403 does not boot
In-Reply-To: <EJEFJPEGEFDHNKNCEDPOOEJKCEAA.BSowislo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0701120842o1c06bc48h8785b5d00843fd74@mail.gmail.com>
	<EJEFJPEGEFDHNKNCEDPOOEJKCEAA.BSowislo@gmx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/17/07, Bernd Sowislo <BSowislo@gmx.de> wrote:
> Hi,
> I have seen your name in the header of
> the files for the temac implementation
> of the ml403 board.
> Meanwhile I know what is the reason
> for the hangup of my kernel at boot time
> when I insert the patches for the temac
> into the xilinx_ml403.c code (two places)
>
> 1. increment ther number of devices scanned at early boot
> 2.) insert the temac routines in ml403_setup_arch()
>
> the systems stops execution.

Do you get any log output at all?  Post it here if you do.

>
> First I thought it was my fault because I use temac 2.0
> with DMA 3.0 and your driver obviously uses DMA 2.0 and temac 1.0

It's not my driver; I've haven't got the temac driver working on my
board yet.  But there are folks on this list who can help you out.

>
> then I changed the code (adapter.c) for use of DMA 3.0 and temac 2.0
> as described in the xilinx example for DMA test but
> even if I use fifo 2.0 mode I have this hangup.
>
> Do you have a driver patch for temac 2.0 with DMA 3.0
> or are you interested in my try to change the code?

The Xilinx drivers are a bit of a disaster at the moment in that it
takes a lot of work to get them right.  Go ahead and change the code.
Fill it with debug output; whatever you need to figure out what's
going on.

>
> how can I debug the booting kernel.

Best way is with some kind of JTAG debugger.  I personally use a
BDI-2000 from Abatron.  I think others have had good luck with the
Xilinx JTAG pod.

>
> my experience in linux is 8 weeks, OVMS 15 years

OVMS?


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
