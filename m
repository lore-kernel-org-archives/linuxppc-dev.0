Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 4465CDDE28
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 04:27:57 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so250355anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 08 May 2008 11:27:51 -0700 (PDT)
Message-ID: <fa686aa40805081127q3aa0af59va86320e266aeea44@mail.gmail.com>
Date: Thu, 8 May 2008 12:27:50 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.
In-Reply-To: <20080508182534.82DF2129805E@mail16-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080508161529.65566FB805F@mail185-va3.bigfish.com>
	<20080508182534.82DF2129805E@mail16-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 8, 2008 at 12:25 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> ePAPR drafts propose 'simple-bus' as a generic compatibility type for
>  busses which cannot be probed for devices.  In addition, the Xilinx
>  versions of these IPs seem to be proliferating.  Hence, in the future
>  let's prefer to use the standard names.  I've left the old names in
>  for short term backward compatibility for existing device trees.
>
>  Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

I'll queue this up for .27

Cheers,
g.

>  ---
>   arch/powerpc/platforms/40x/virtex.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
>  diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
>  index 6c72994..b1ab7b8 100644
>  --- a/arch/powerpc/platforms/40x/virtex.c
>  +++ b/arch/powerpc/platforms/40x/virtex.c
>  @@ -16,6 +16,7 @@
>   #include <asm/xilinx_intc.h>
>
>   static struct of_device_id xilinx_of_bus_ids[] __initdata = {
>  +       { .compatible = "simple-bus", },
>         { .compatible = "xlnx,plb-v46-1.00.a", },
>         { .compatible = "xlnx,plb-v46-1.02.a", },
>         { .compatible = "xlnx,plb-v34-1.01.a", },
>  --
>  1.5.3.4
>
>
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
