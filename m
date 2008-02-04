Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id A87BEDDECF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Feb 2008 02:32:14 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so650559anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 04 Feb 2008 07:32:13 -0800 (PST)
Message-ID: <fa686aa40802040732q62f67f1exd9ec41da1f08ff8f@mail.gmail.com>
Date: Mon, 4 Feb 2008 08:32:13 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: IngoM <ingo.maindorfer@ipm.fraunhofer.de>
Subject: Re: [Virtex 4 PPC] Which Linux?
In-Reply-To: <15268468.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <15268468.post@talk.nabble.com>
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

On 2/4/08, IngoM <ingo.maindorfer@ipm.fraunhofer.de> wrote:
>
> Hello,
>
> we develop a new laser-ranging-system and our hardware freaks have choosen
> the Virtex 4 FX 12 on the "AVNET FX12 Mini-Module". The system had to
> deliver the raw data via UDP (12 Mbyte/sec) and on TCP the processed data
> (about 6 Mbyte/sec). When you get the processed data via TCP then no data
> send by UDP.
>
> I'm confused by the following:
>
> 1) Hard-TEMAC vs. Soft-TEMAC.
> Avnet provide a demo for the module which using Soft-TEMAC. If I get it
> right this core has to be licenced. But when ther is a hard-TEMAC why pay
> for it?

Use the hard TEMAC.

> 2) Linux
> I'd like to build my kernel and filesystem myself. But which way to go?
> Using OE, buildroot, ELDK...
> Can you please provide some starting points for me?

I've got buildroot working; it's probably the simplest for building
from scratch.  ELDK works well too.

http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex

>
> 3) Boot-Concept
> The Mini-Module had only 4MB Flash. Is this enough for a root-fs?

It's tight, but doable.  You kernel image will be somewhere around 1
to 1.5 MB.  Depends on how big your application is.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
