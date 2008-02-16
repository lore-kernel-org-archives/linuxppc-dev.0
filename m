Return-Path: <leon.woestenberg@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id DDD60DDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Feb 2008 23:44:30 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so693299anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Feb 2008 04:44:29 -0800 (PST)
Message-ID: <c384c5ea0802160444y2e15723fmbe1fd964dc2274a6@mail.gmail.com>
Date: Sat, 16 Feb 2008 13:44:29 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: High resolution timer support in 2.6.24+ for MPC831x?
In-Reply-To: <c384c5ea0802151249v348dd06w6e1d65928699d00e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c384c5ea0802141226m630fcc11h60627cde75cb8b0e@mail.gmail.com>
	<47B4A9D7.3030100@freescale.com>
	<c384c5ea0802151249v348dd06w6e1d65928699d00e@mail.gmail.com>
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

Hello,

On Feb 15, 2008 9:49 PM, Leon Woestenberg <leon.woestenberg@gmail.com> wrote:
> On Thu, Feb 14, 2008 at 9:51 PM, Scott Wood <scottwood@freescale.com> wrote:
> > Leon Woestenberg wrote:
> >  > My platform is a MPC8313E-RDB, and I suspect no high res clock source
> >  > implementation exists for it in 2.6.24, because
> >  > clock_getres(CLOCK_REALTIME,) gives me 1/HZ.
> >  >

I found that 2.6.24 needs the patch "[PATCH] Fix powerpc vdso
clock_getres()" posted February 8th on linuxppc-dev (which I missed,
sorry for the noise).

That seems to fix it in a quick test:

root@mpc8313e-rdb:~$ /timers
Clock resolution (clockid 0): 0.000000001
Clock resolution (clockid 1): 0.000000001


Regards,
-- 
Leon
