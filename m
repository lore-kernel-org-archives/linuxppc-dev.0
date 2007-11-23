Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 24579DDE44
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 07:30:39 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so538322anc
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 12:30:38 -0800 (PST)
Message-ID: <fa686aa40711231230o28e1c266s70f2819cb641d236@mail.gmail.com>
Date: Fri, 23 Nov 2007 13:30:38 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Hardware debuggers for PPC74xx G4 CPUs
In-Reply-To: <9e4733910711231226p44541777n4a1190c0ecf5bb55@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071118004729.67824247F1@gemini.denx.de>
	<1195774625.6970.145.camel@pasglop>
	<9e4733910711221600t378a3afate51cc798df0d8b8d@mail.gmail.com>
	<1195777323.6970.153.camel@pasglop>
	<9e4733910711230703w3a8ba108ybfdd0a9f2bf6f537@mail.gmail.com>
	<9e4733910711231226p44541777n4a1190c0ecf5bb55@mail.gmail.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/23/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 11/23/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 11/22/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > >
> > > On Thu, 2007-11-22 at 19:00 -0500, Jon Smirl wrote:
> > > > > It seems like AMCC does provide the necessary infos for 4xx
> > > > processors
> > > > > though. Jon, do you think what they provide is enough to use an open
> > > > > source debugger ?
> > > >
> > > > Do you have a link to the info?
> > >
> > > Not at hand, but easy to find from AMCC main product page, you can then
> > > go to the various eval board download pages, and some of the d/l are
> > > infos for JTAG debugger manufacturers.
>
> Grant, I heard back from the Amontec (a JTAG company) developers. They
> are interested in doing an open JTAG for the Xilinx Microblaze.  Is
> that the FPGA you've been working with?

Yes, the FPGA I'm using can host a Microblaze design; except my work
has focused on the ppc405 hard IP core instead of the microblaze core.

Regardless, this sounds interesting.  Can you get JTAG debug info out of Xilinx?

Cheers,
g.
.
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
