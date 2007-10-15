Return-Path: <benh@kernel.crashing.org>
Subject: RE: Override timer interrupt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B037D5152@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B037D4BA9@ismail.innsys.innovsys.com>
	<20071012213041.GB22894@mag.az.mvista.com>
	<DCEAAC0833DD314AB0B58112AD99B93B037D4C1B@ismail.innsys.innovsys.com>
	<1192229894.22054.29.camel@pasglop>
	<DCEAAC0833DD314AB0B58112AD99B93B037D4F05@ismail.innsys.innovsys.com>
	<1192481753.11795.25.camel@pasglop>
	<DCEAAC0833DD314AB0B58112AD99B93B037D5152@ismail.innsys.innovsys.com>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 07:58:18 +1000
Message-Id: <1192485498.11795.41.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-15 at 16:50 -0500, Rune Torgersen wrote:
> Huh? Not in 2.6.18/arch/ppc at least, unless I'm completely
> misundrstanding the code.
> ppc/powerpc seems to be using clocksource_jiffies as the clock source,
> and teh gettimeofday gets xtime + a offset from last jiffie, and xtime
> is updated with a fixed amount per tick.
> 
> Things have changed a lot since I last delved deep into this to try to
> ge an accurate freerunning clock (2.6.12).

Hrm... 2.6.18 doesn't have clock sources in the first place, what kernel
are you using ?

Ben.
