Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 3CA89DDE3C
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 02:03:11 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3873980wag
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 07:03:10 -0800 (PST)
Message-ID: <9e4733910711230703w3a8ba108ybfdd0a9f2bf6f537@mail.gmail.com>
Date: Fri, 23 Nov 2007 10:03:09 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: Hardware debuggers for PPC74xx G4 CPUs
In-Reply-To: <1195777323.6970.153.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071118004729.67824247F1@gemini.denx.de>
	<1195774625.6970.145.camel@pasglop>
	<9e4733910711221600t378a3afate51cc798df0d8b8d@mail.gmail.com>
	<1195777323.6970.153.camel@pasglop>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/22/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Thu, 2007-11-22 at 19:00 -0500, Jon Smirl wrote:
> > > It seems like AMCC does provide the necessary infos for 4xx
> > processors
> > > though. Jon, do you think what they provide is enough to use an open
> > > source debugger ?
> >
> > Do you have a link to the info?
>
> Not at hand, but easy to find from AMCC main product page, you can then
> go to the various eval board download pages, and some of the d/l are
> infos for JTAG debugger manufacturers.

Dominick Rath wrote OpenOCD (open source JTAG) as his senior thesis in
college, he graduated this spring and has a job now. I've sent mail to
him but he may be a lost cause.
Thesis: http://developer.berlios.de/docman/display_doc.php?docid=1367&group_id=4148

Low cost dev tools are an important part of the CPU selection process.
We went through four ARM CPUs before deciding on the MPC5200. We were
able to get ARM eval boards and JTAGs for under $500 for each of the
eval CPUs. We used the low cost evals to screen the CPUs, we didn't
want spend $5-10K until we are 90% sure we are going to use the CPU. I
returned one $5K eval board, it was a pain and it took over six months
to get a refund.

We have also learned the hard way about "port and forget" several of
the CPUs we picked had Linux ports, but the ports were five years old.
When we pushed the vendors for more recent kernels the typical answer
was, send us $50,000 and we'll see what we can do. We're not going to
send in $50K for a CPU we haven't decided to use, that answer simply
resulted in us changing CPUs. An example of this is the NXP LPC3180,
$9 with a FPU, but only a 2.6.5 kernel.

I've also only seen ARM CPUs being used in schools. You can get ARM
eval boards and a JTAG for under $100 on some ARM CPUs. AFAIK there is
no low cost PowerPC option suitable for classroom use.

-- 
Jon Smirl
jonsmirl@gmail.com
