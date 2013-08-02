Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BCB6C2C0097
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Aug 2013 08:11:00 +1000 (EST)
Message-ID: <1375481448.15999.47.camel@pasglop>
Subject: Re: windfarm_fcu_controls: cpu-pump-0 <HW FAULT>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Sat, 03 Aug 2013 08:10:48 +1000
In-Reply-To: <87r4eb52s6.fsf@igel.home>
References: <87r4eb52s6.fsf@igel.home>
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

On Fri, 2013-08-02 at 21:08 +0200, Andreas Schwab wrote:
> wf_fcu_fan_get_rpm is returning EFAULT when reading the values for the
> cpu pump controls on the PowerMac7,3.  Also, wf_fcu_get_pump_minmax is
> unable to get the real limits and falls back to using the defaults.
> 
> Here is the output when DEBUG is defined:

Can you add some more printk's in there to check what's going on inside
wf_fcu_get_pump_minmax() ?

Also is it getting faults for both pumps ?

Does it work with the older driver ? (both the minmax and the reading of
the pump). What is the "failures" bitmask value ?

Cheers,
Ben.
