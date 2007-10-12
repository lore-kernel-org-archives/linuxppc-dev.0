Return-Path: <mgreer@mvista.com>
Date: Fri, 12 Oct 2007 14:55:45 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Override timer interrupt
Message-ID: <20071012215545.GE22894@mag.az.mvista.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B037D4BA9@ismail.innsys.innovsys.com>
	<20071012213041.GB22894@mag.az.mvista.com>
	<DCEAAC0833DD314AB0B58112AD99B93B037D4C1B@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B037D4C1B@ismail.innsys.innovsys.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 12, 2007 at 04:39:53PM -0500, Rune Torgersen wrote:
> > From: Mark A. Greer 
> > > Is there an easy way to use something other than the decrementer for
> the
> > > timer interrupt?
> 
> > Check out the clocksource stuff.  It let's you set up numerous clock
> > sources and set the rating of each one.  You can start looking in
> > arch/powerpc/kernel/time.c for example code.
> 
> Thanks I will. 
> Currently our board port lives in /arch/ppc (2.6.18) but I will take a
> look in powerpc.

Okay.  Just an FYI, arch/ppc will evaporate next summer.

Mark
