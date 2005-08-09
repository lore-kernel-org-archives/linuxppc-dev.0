Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 964946801C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 03:20:56 +1000 (EST)
Date: Tue, 9 Aug 2005 10:20:53 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Rune Torgersen <runet@innovsys.com>
Message-ID: <20050809172053.GA29942@gate.ebshome.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B859418@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859418@ismail.innsys.innovsys.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Wall clock accuracy
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2005 at 12:04:10PM -0500, Rune Torgersen wrote:
> 
> My bigger problem with the walltime is that time_nsec should have been
> 1000000, not 999848 to begin with. If it had been, I would probably
> never even have noticed it.
> 
> The thing is that that value is set based on a value I cannot find any
> reference as how was chosen. Looks to be a leftover when porting PPC
> fron i386 once upon a time.
> 
> time_nsec basically gets is value (via some macros) from
> CLOCK_TICK_RATE, which is defined in asm-ppc/timex.h to be 1193180
> 
> In my opinion, time_nsec should have been calculated based on the actual
> clock input rate to begin with (like in calibrate_decrementer()).

Fair enough, why then instead of fixing the root cause you are making 
ugly workarounds :) ?

-- 
Eugene
