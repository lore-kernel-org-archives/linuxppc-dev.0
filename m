Return-Path: <glikely@secretlab.ca>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.191])
	by ozlabs.org (Postfix) with ESMTP id 222C9DE18C
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 00:01:33 +1100 (EST)
Received: by gv-out-0910.google.com with SMTP id p33so708471gvf.14
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 06:01:21 -0700 (PDT)
Message-ID: <fa686aa40803260601j6e7f507fpe4d31c7c462fce5e@mail.gmail.com>
Date: Wed, 26 Mar 2008 07:01:16 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
Subject: Re: Patch: FW:Xilinx: BSP: Updated ML405 to match hardware used for
	testing
In-Reply-To: <052801c88f37$3b51f7e0$ad289e86@LPSC0173W>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <052801c88f37$3b51f7e0$ad289e86@LPSC0173W>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 5:47 AM, Guillaume Dargaud
<dargaud@lpsc.in2p3.fr> wrote:
> Hello all,
>
>  I'm trying to get things up and running on a Xilinx Virtex-4 ml405 board,
>  and as such I've been trying to figure out the following recent message to
>  the list:
>  http://patchwork.ozlabs.org/linuxppc/patch?person=1226&id=17037
>
>  I don't understand what this patch applies to: it references files such as
>  ml405_defconfig which are not part of the normal kernel tree and which I
>  cannot find anywhere. Is there some other kind of patch that needs to apply
>  first in order to get for instance CONFIG_XILINX_DRIVERS,
>  CONFIG_XILINX_EMAC, etc...
>
>  Thanks

It applies to Xilinx's git tree of the Linux kernel.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
