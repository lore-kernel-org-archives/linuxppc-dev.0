Date: Thu, 3 Jun 2004 08:46:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Matt Porter <porter@cox.net>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: new dma API questions
Message-ID: <20040603154624.GM15195@smtp.west.cox.net>
References: <40BEEA15.3070505@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40BEEA15.3070505@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 03, 2004 at 12:06:29PM +0300, Pantelis Antoniou wrote:

> Hi there.
>
> I have a few questions regarding the new DMA API.
[snip]
> 3. The first argument is dma_* function is a struct device.
>   When working with network devices I must set this to NULL.
>   Granted this is no problem right now, but could this be
>   a problem in the future?

It could be a problem in the future, but probably not until cpm1/cpm2
stuff uses OCP bits, which would have a dev entry to pass in (AFAIK,
there aren't plans to make use of dev yet, so...).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
