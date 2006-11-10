Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17749.4257.415783.451756@cargo.ozlabs.ibm.com>
Date: Sat, 11 Nov 2006 10:52:01 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] PowerPC: clockevents and HRT support
In-Reply-To: <455487E2.9040701@ru.mvista.com>
References: <200611080005.08633.sshtylyov@ru.mvista.com>
	<1162938997.28571.534.camel@localhost.localdomain>
	<45510C58.3010707@ru.mvista.com>
	<17745.14911.693171.717979@cargo.ozlabs.ibm.com>
	<4551E7FF.8010209@ru.mvista.com>
	<17748.14621.231956.561842@cargo.ozlabs.ibm.com>
	<455487E2.9040701@ru.mvista.com>
Cc: tglx@linutronix.de, greg.weeks@timesys.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov writes:

>     I think the usual rule is: "you want it, you do it". ;-)

Sure!  And I will, at some point, if someone else doesn't do it
first.

My point is simply that as maintainer I won't accept a patch that
breaks an important feature, even if it adds another important
feature.

>     Seriously, we have neither time, not hardware, nor docs for the h/w this 
> accounting option applies to.

Really?  You're working on machines that don't have a timebase
register?  What powerpc chip doesn't have a timebase register, other
than the really old 601? :)  The timebase is all the hardware that is
needed.

> And coercing the generic clcokevents/hrtimers 
> code into calling the arch hooks is serious design decision which I felt is 
> better to be left to Thomas as a maintainer...

CONFIG_VIRT_CPU_ACCOUNTING is used, and needed, on powerpc and s390,
both of which also want to do dynticks.  If the current framework
can't cope with that, then it needs to be extended.

Paul.
