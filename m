Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id C50CADE140
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 01:54:07 +1000 (EST)
Date: Tue, 29 May 2007 17:54:05 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
In-Reply-To: <624dd5293b5fde0ffdf01ea692c32e9c@kernel.crashing.org>
Message-ID: <Pine.LNX.4.62.0705291753370.7698@pademelon.sonytel.be>
References: <1180423456.19517.124.camel@localhost.localdomain>
	<20070529092658.GA32228@iram.es>
	<08b3997ab86a819c63b5cb0afcdc0c9e@kernel.crashing.org>
	<200705291628.35852.arnd@arndb.de>
	<624dd5293b5fde0ffdf01ea692c32e9c@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Arnd Bergmann <arnd@arndb.de>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Steve Munroe <sjmunroe@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 29 May 2007, Segher Boessenkool wrote:
> > right, as mentioned before, IP32L64 would imply introducing a new
> > ABI, which we don't want.
> 
> Hey, you could hijack the mswindows ABI, no need to
> define your own ;-)

Isn't that (IL32)P64?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
