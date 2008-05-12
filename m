Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.236])
	by ozlabs.org (Postfix) with ESMTP id 8AC77DDED5
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 00:24:43 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i30so1892754wxd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 07:24:41 -0700 (PDT)
Message-ID: <fa686aa40805120724u17a380adnd0826044ae3ac369@mail.gmail.com>
Date: Mon, 12 May 2008 08:24:41 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] Xilinx: framebuffer: add compatibility for ml507 dvi core.
In-Reply-To: <20080505175918.2AD03A58056@mail164-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080505175918.2AD03A58056@mail164-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 5, 2008 at 11:59 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>  ---
>   drivers/video/xilinxfb.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
>  diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
>  index 848752e..a82c530 100644
>  --- a/drivers/video/xilinxfb.c
>  +++ b/drivers/video/xilinxfb.c
>  @@ -396,6 +396,7 @@ static int __devexit xilinxfb_of_remove(struct of_device *op)
>   /* Match table for of_platform binding */
>   static struct of_device_id xilinxfb_of_match[] __devinitdata = {
>         { .compatible = "xlnx,plb-tft-cntlr-ref-1.00.a", },
>  +       { .compatible = "xlnx,plb-dvi-cntlr-ref-1.00.c", },

Can you get the dvi core to claim compatibility with the tft core
(assuming it is register level backwards compatible)?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
