Return-Path: <kylo.ginsberg@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.197])
	by ozlabs.org (Postfix) with ESMTP id E038567A75
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 08:39:08 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id g11so1421528rne
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 May 2005 15:39:07 -0700 (PDT)
Message-ID: <61cc712d050516153941bc3b26@mail.gmail.com>
Date: Mon, 16 May 2005 15:39:07 -0700
From: Kylo Ginsberg <kylo.ginsberg@gmail.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050516220330.6D4E3C1512@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <61cc712d05051614507b688c6e@mail.gmail.com>
	<20050516220330.6D4E3C1512@atlas.denx.de>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC885 - USB HCI drivers.
Reply-To: Kylo Ginsberg <kylo.ginsberg@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/16/05, Wolfgang Denk <wd@denx.de> wrote:
> This code will NOT work on a MPC885.  It  was  written  for  the  old
> MPC823/850  processors,  and it NEVER worked really reliably on these
> systems either.
=20
Ok, thanks.  Good to know!  Do you know of a driver for the 885, or
for the 8555E?

> My advice: use a _real_ USB controller.

Are there known problems with CPM-based USB controllers?  I'm
completely new to the subject, but we are designing a board assuming
we can use the USB controller on an MPC8555E.

Thanks for any comments.  If there are gotchas here, I'd love to find
out about them sooner rather than later.

Cheers,
Kylo
