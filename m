Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E39482C0092
 for <linuxppc-dev@ozlabs.org>; Sun,  4 Aug 2013 12:45:19 +1000 (EST)
Message-ID: <1375582866.15999.86.camel@pasglop>
Subject: Re: windfarm_fcu_controls: cpu-pump-0 <HW FAULT>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Sun, 04 Aug 2013 12:21:06 +1000
In-Reply-To: <87mwoyhmj9.fsf@igel.home>
References: <87r4eb52s6.fsf@igel.home>
 <1375481448.15999.47.camel__48019.1930350431$1375481501$gmane$org@pasglop>
 <m2vc3nnp01.fsf@linux-m68k.org>
 <1375519493.15999.83.camel__49452.0221990117$1375519543$gmane$org@pasglop>
 <87r4eahoka.fsf__2165.9838072539$1375537818$gmane$org@igel.home>
 <87mwoyhmj9.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-08-03 at 16:33 +0200, Andreas Schwab wrote:
> But then, MacOS is happy and the hardware test didn't find anything
> either...

Ok, I'll take another peek at the MacOS code see if there's anything
meaningful there (though we don't have the complete stuff, I think the
fault mask we decoded from the OFW methods).

Cheers,
Ben.
