Return-Path: <david-b@pacbell.net>
Received: from smtp102.sbc.mail.mud.yahoo.com (smtp102.sbc.mail.mud.yahoo.com
	[68.142.198.201]) by ozlabs.org (Postfix) with SMTP id 7D8CADE0C5
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 05:29:06 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Freescale QUICC Engine USB Host Controller
Date: Thu, 3 Apr 2008 11:22:23 -0700
References: <20080311191744.GA10518@localhost.localdomain>
	<20080403143052.GA5955@polina.dev.rtsoft.ru>
	<47F4F8B0.4090708@freescale.com>
In-Reply-To: <47F4F8B0.4090708@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804031122.24442.david-b@pacbell.net>
Cc: Scott Wood <scottwood@freescale.com>, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 03 April 2008, Timur Tabi wrote:
> > Well, there is Linux CLK API (somewhat similar to GPIO API), but PowerPC
> > doesn't use it yet.
> 
> Yeah, I noticed that too.  I'll add it to my to-do list, but I suspect that
> someone else will get around to it before I do.

Note that there's some work afoot to provide a generic
implementation framework for the clk_*() calls.  It was
last posted on the ARM list ... I'd hope it would make
it easier for at least some PowerPC platforms to support
that interface.

- Dave
