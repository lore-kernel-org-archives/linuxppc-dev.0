Return-Path: <trini@kernel.crashing.org>
Date: Thu, 4 Nov 2004 11:56:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Message-ID: <20041104185629.GD13456@smtp.west.cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DBA1@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DBA1@ismail.innsys.innovsys.com>
Cc: dwmw2@shinybook.infradead.org, Linuxppc-embedded@ozlabs.org
Subject: Re: Possible CPM2 SMC bug
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 25, 2004 at 06:25:20PM -0500, Rune Torgersen wrote:

> The output from INIT (sysvinit 2.85) is garbled when runninn on kernel 2.6.9 and using SMC1 as the console port
> When runnign SCC1 as console port, no garbling occurs.
> Only the output from INIT seems to be garbled. And only output that does not show up on netconsole.
> 
> The problem was not present in 2.6.7, which used the old smc/scc uart drivers.

It sounds like the clock rate isn't quite right on SMC1.  Any chance
you've worked this problem out more?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
