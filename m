Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id D2D0DDDFA1
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 05:06:48 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5417276wag
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 12:06:47 -0700 (PDT)
Message-ID: <fa686aa40710021206v7ed7f788u4aeb96bc26ca4f4@mail.gmail.com>
Date: Tue, 2 Oct 2007 13:06:47 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [PATCH v3 02/12] Virtex: Add Kconfig macros for Xilinx Virtex
	board support
In-Reply-To: <87ejgdz6c6.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071002021334.9579.68179.stgit@trillian.cg.shawcable.net>
	<20071002021518.9579.24264.stgit@trillian.cg.shawcable.net>
	<87ejgdz6c6.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/2/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
>
>  Grant> +config XILINX_VIRTEX_II_PRO
>  Grant> +       bool
>  Grant> +       select XILINX_VIRTEX
>  Grant>         select IBM405_ERR77
>  Grant>         select IBM405_ERR51
>
>  Grant> +config XILINX_VIRTEX_4_FX
>  Grant> +       bool
>  Grant> +       select XILINX_VIRTEX
>  Grant> +
>
> This seems different than under arch/ppc - The errattas were also
> enabled for the V4FX - What is correct?

I'll need to take another look.  I made a mental point to look at it
last week when I wrote it, but apparently I forgot.  :-(

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
