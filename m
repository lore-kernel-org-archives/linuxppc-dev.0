Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17748.21645.621069.105453@cargo.ozlabs.ibm.com>
Date: Fri, 10 Nov 2006 21:29:33 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kalle Pokki <kalle.pokki@iki.fi>
Subject: Re: [PATCH] CPM_UART: Fix non-console initialisation (v2)
In-Reply-To: <Pine.LNX.4.64.0611011457490.3387@host32.eke.fi>
References: <Pine.LNX.4.64.0611011457490.3387@host32.eke.fi>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kalle Pokki writes:

> This is a cleaned-up version of a patch sent on Oct 19th. The patch is 
> fairly straightforward and does not affect other than the compat mode. As 
> not having this patch renders the cpm_uart driver unusable with a frame 
> buffer console, I think this should be included in 2.6.19.

The last hunk, i.e. the change to drivers/serial/cpm_uart/cpm_uart_cpm2.c,
doesn't apply because cpm_uart_init_portdesc now looks different to the
context in your patch, so I dropped that hunk (it looked to be pretty
much independent of the other changes).

Also, the whitespace is damaged throughout this and your other
patches.  I fixed it up this time, but please fix your mailer not to
munge the whitespace.  Specifically, where a line begins with a space
character, your mailer removes it if there is nothing else on the
line, or turns it into two spaces otherwise. :P

Paul.
