Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by ozlabs.org (Postfix) with ESMTP id 57C8DDDFE0
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 01:16:20 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so2537378nzh
	for <linuxppc-dev@ozlabs.org>; Mon, 01 Oct 2007 08:16:20 -0700 (PDT)
Message-ID: <fa686aa40710010816g6bf66498s659c1c3f78b22df1@mail.gmail.com>
Date: Mon, 1 Oct 2007 09:16:19 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCHv2 3/4] Virtex: add xilinx interrupt controller driver
In-Reply-To: <20071002010819.6f2736be.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070930221613.583.252.stgit@trillian.cg.shawcable.net>
	<20070930222038.583.20385.stgit@trillian.cg.shawcable.net>
	<20071002010819.6f2736be.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/1/07, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Sun, 30 Sep 2007 16:20:43 -0600 Grant Likely <grant.likely@secretlab.ca> wrote:
> >
> > diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
> > new file mode 100644
> > index 0000000..69f05cd
> > --- /dev/null
> > +++ b/arch/powerpc/sysdev/xilinx_intc.c
> > @@ -0,0 +1,151 @@
> > +#include <linux/kernel.h>
> > +#include <linux/irq.h>
> > +#include <asm/io.h>
> > +#include <asm/processor.h>
> > +#include <asm/prom.h>
>
> You probably want linux/of_device.h or linux/of.h instead of asm/prom.h

Done.

Thanks for the comments,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
