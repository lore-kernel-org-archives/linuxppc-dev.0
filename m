Return-Path: <kallepokki@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id A948867DFD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Nov 2006 22:45:23 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id p76so315949pyb
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Nov 2006 03:45:22 -0800 (PST)
Message-ID: <a425f86c0611100345h40b104cchdb766e35f1767656@mail.gmail.com>
Date: Fri, 10 Nov 2006 13:45:21 +0200
From: "Kalle Pokki" <kalle.pokki@iki.fi>
Sender: kallepokki@gmail.com
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH] CPM_UART: Fix non-console initialisation (v2)
In-Reply-To: <17748.21645.621069.105453@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <Pine.LNX.4.64.0611011457490.3387@host32.eke.fi>
	<17748.21645.621069.105453@cargo.ozlabs.ibm.com>
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

On 11/10/06, Paul Mackerras <paulus@samba.org> wrote:
>
> The last hunk, i.e. the change to drivers/serial/cpm_uart/cpm_uart_cpm2.c,
> doesn't apply because cpm_uart_init_portdesc now looks different to the
> context in your patch, so I dropped that hunk (it looked to be pretty
> much independent of the other changes).

OK, better drop all the hunks except the one that concerns
drivers/serial/cpm_uart/cpm_uart_core.c then, since I added the same
'__init' lines in cpm_uart.h, cpm_uart_cpm1.c, and cpm_uart_cpm2.c.

> Also, the whitespace is damaged throughout this and your other
> patches.  I fixed it up this time, but please fix your mailer not to
> munge the whitespace.  Specifically, where a line begins with a space
> character, your mailer removes it if there is nothing else on the
> line, or turns it into two spaces otherwise. :P

I'll fix this. It seems I was sending the patches with pine making them flowed.
