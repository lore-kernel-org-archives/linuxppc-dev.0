To: =?iso-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel oops with MPC5200 UDMA. How to debug? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 24 Jun 2004 11:06:05 +0200."
             <42A622EB18325843894BB8E1040E3DF5022764@sinaexchf>
Date: Thu, 24 Jun 2004 19:42:50 +0200
Message-Id: <20040624174255.C28B9C13D3@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <42A622EB18325843894BB8E1040E3DF5022764@sinaexchf> you wrote:
>
> Seems that the DMA is still broken even if the FEC support is disabled.

Indeed. Freescale says they are working on this.

> Is there a way to find where the problem is without using a BDI? We don't have any of those tools yet, but a Metrowerks wiretap which seems to be not supported on linux.

It's the other way round, i. e. the wiretap does not support Linux.

You can decode the backtrace maually from the System.map file, or you
can use our backtrace script for this purpose:
ftp://ftp.denx.de/pub/tools/backtrace

But in the end you will want to have a BDI200 anyway ;-)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The inappropriate cannot be beautiful.
             - Frank Lloyd Wright _The Future of Architecture_ (1953)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
