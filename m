Return-Path: <david-b@pacbell.net>
Received: from smtp118.sbc.mail.sp1.yahoo.com (smtp118.sbc.mail.sp1.yahoo.com
	[69.147.64.91]) by ozlabs.org (Postfix) with SMTP id F0499DDDD8
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 08:45:15 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: dvomlehn@cisco.com,
 Grant Erickson <gerickson@nuovations.com>
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
Date: Tue, 25 Nov 2008 13:45:10 -0800
References: <20081125135519.038abf23@zod.rchland.ibm.com>
	<492C5DC2.9040402@billgatliff.com>
	<1227646490.5404.5.camel@cuplxvomd02.corp.sa.net>
In-Reply-To: <1227646490.5404.5.camel@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811251345.11350.david-b@pacbell.net>
Cc: Bill Gatliff <bgat@billgatliff.com>, Wolfgang Denx <wd@denx.de>,
	linux-embedded@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

No comment from me on $SUBJECT beyond "it seems plausible", but ...

On Tuesday 25 November 2008, David VomLehn wrote:
> The important point, though, is that device tree is the only
> thing approaching a standard on any non-x86-based platform for passing
> structured information from the bootloader to the kernel. The command
> line is just not sufficient for this.

Me, I'll be happier if I don't have to try using that device tree.
Having board-specific code in the kernel is a more complete solution,
and makes it a lot easier to cope with all the hardware goofage.

Recall that the *original* notion behind OpenBoot (now "OpenFirmware")
was to have tables for the stuff that was table-friendly, and call
out to FORTH code (possibly not just at boot time) for the rest.
(Given the choice of FORTH vs ACPI bytecodes, I'd go for FORTH; but
the better option is "neither".)

Right now I see an awful lot of work going into trying to force lots
of stuff into table format.  Even when it's the sort of one-off or
board-specific quirkery that was an original motivation for having
FORTH escapes (tasks that were not table-friendly).

- Dave
