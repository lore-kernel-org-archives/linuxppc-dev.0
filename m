Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id DDCA0DDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 21:23:52 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: "Remi Lefevre" <rlefevre@gmail.com>
Subject: Re: FHCI driver adaptation for CPM2
Date: Thu, 18 Dec 2008 11:23:48 +0100
References: <4e0b9cb00812170710n3374d558xab3584dc61980756@mail.gmail.com>
	<200812171633.58081.laurentp@cse-semaphore.com>
	<4e0b9cb00812171227g47647d31ufaec827ddbab0232@mail.gmail.com>
In-Reply-To: <4e0b9cb00812171227g47647d31ufaec827ddbab0232@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812181123.48550.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Remi,

On Wednesday 17 December 2008 21:27:49 Remi Lefevre wrote:
> >> Also 40% seems quite a lot, even at 1000Hz interruptions, an idea how
> >> much does the CRC computation contribute in this CPU hogging ?
> >
> > I haven't measured that, but probably not much. The biggest CPU time
> > eater isn't the SOF generation interrupt but the USB packet handling
> > code. The CPM2 USB host controller is really too low-level to be usable
> > (except maybe for specific applications). Comparing the OHCI/UHCI/EHCI
> > and FHCI controllers is akin to  bit like comparing a full 16550 UART
> > with a software bit-bang implementation. You can get around with it, it
> > might work for your specific application, but you shouldn't try a full
> > speed 115200bds communication while computing a CPU-hungry physical
> > simulation.
>
> That's what I was afraid of. I now understand clearly why you didn't expect
> that much better performance with CPM3 in a past message
> (http://ozlabs.org/pipermail/linuxppc-embedded/2008-May/030508.html).
> Still, as you said, it can have some use for specific applications.
>
> Do you remember the throughput you were able to reach with this cpu
> overhead ?

I'm sorry I don't.

Best regards,

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
