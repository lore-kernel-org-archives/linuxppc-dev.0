Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by ozlabs.org (Postfix) with ESMTP id D8CCDDDEFE
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 08:33:10 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so365487wri.3
	for <linuxppc-dev@ozlabs.org>; Wed, 07 May 2008 15:33:09 -0700 (PDT)
Message-ID: <fa686aa40805071533m546b4954u1c6e88e7224f035c@mail.gmail.com>
Date: Wed, 7 May 2008 16:33:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for IBM coreconnect
	busses.
In-Reply-To: <20080507204734.574B6185804E@mail138-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080507204734.574B6185804E@mail138-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 7, 2008 at 2:47 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> The IBM coreconnect names are pretty well defined, it appears.  In
>  addition, the Xilinx versions of these IPs seem to be proliferating.
>  Hence, in the future let's prefer to use the standard names.  I've
>  left the old names in for some backward compatibility for existing
>  device trees.
>
>  Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Acked-by: Grant Likely <grant.likey@secretlab.ca>

I think we can probably give it a release or two and then drop the
older stuff in the list.  Virtex support is still very new, so it is
unlikely that there are many (any?) users out there that won't be
keeping up to date with the xilinx device tree changes.

Cheers,
g.

>  ---
>   arch/powerpc/platforms/40x/virtex.c |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
>  diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
>  index 6c72994..7e1c0e3 100644
>  --- a/arch/powerpc/platforms/40x/virtex.c
>  +++ b/arch/powerpc/platforms/40x/virtex.c
>  @@ -16,11 +16,15 @@
>   #include <asm/xilinx_intc.h>
>
>   static struct of_device_id xilinx_of_bus_ids[] __initdata = {
>  +       { .compatible = "ibm,plb3", },
>  +       { .compatible = "ibm,plb4", },
>         { .compatible = "xlnx,plb-v46-1.00.a", },
>         { .compatible = "xlnx,plb-v46-1.02.a", },
>         { .compatible = "xlnx,plb-v34-1.01.a", },
>         { .compatible = "xlnx,plb-v34-1.02.a", },
>  +       { .compatible = "ibm,opb", },
>         { .compatible = "xlnx,opb-v20-1.10.c", },
>  +       { .compatible = "ibm,dcr", },
>         { .compatible = "xlnx,dcr-v29-1.00.a", },
>         { .compatible = "xlnx,compound", },
>         {}
>  --
>  1.5.3.4
>
>
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
