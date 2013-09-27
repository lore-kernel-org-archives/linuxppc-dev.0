Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA0B92C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 07:33:24 +1000 (EST)
Received: from mail220-tx2 (localhost [127.0.0.1])	by
 mail220-tx2-R.bigfish.com (Postfix) with ESMTP id BF97D340266	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 21:33:19 +0000 (UTC)
Received: from TX2EHSMHS005.bigfish.com (unknown [10.9.14.249])	by
 mail220-tx2.bigfish.com (Postfix) with ESMTP id 44FD0740051	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 21:33:17 +0000 (UTC)
Message-ID: <1380317594.24959.490.camel@snotra.buserror.net>
Subject: Re: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Fri, 27 Sep 2013 16:33:14 -0500
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259010911C2@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1380014925-23300-2-git-send-email-dongsheng.wang@freescale.com>
 <1380014925-23300-4-git-send-email-dongsheng.wang@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0717F8F9@039-SN2MPN1-011.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F154392590108FF41@039-SN2MPN1-021.039d.mgd.msft.net>
 <1380131815.24959.185.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010909C3@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07183D0B@039-SN2MPN1-011.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F1543925901090B4F@039-SN2MPN1-021.039d.mgd.msft.net>
 <1380231435.24959.328.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010911C2@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-26 at 22:34 -0500, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, September 27, 2013 5:37 AM
> > To: Wang Dongsheng-B40534
> > Cc: Bhushan Bharat-R65777; Wood Scott-B07421; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20 state and
> > altivec idle
> > 
> > On Thu, 2013-09-26 at 01:18 -0500, Wang Dongsheng-B40534 wrote:
> > >
> > > > -----Original Message-----
> > > > From: Bhushan Bharat-R65777
> > > > Sent: Thursday, September 26, 2013 12:23 PM
> > > > To: Wang Dongsheng-B40534; Wood Scott-B07421
> > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > Subject: RE: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20 state
> > > > and altivec idle
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Wang Dongsheng-B40534
> > > > > Sent: Thursday, September 26, 2013 8:02 AM
> > > > > To: Wood Scott-B07421
> > > > > Cc: Bhushan Bharat-R65777; linuxppc-dev@lists.ozlabs.org
> > > > > Subject: RE: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20 state
> > > > > and altivec idle
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Wood Scott-B07421
> > > > > > Sent: Thursday, September 26, 2013 1:57 AM
> > > > > > To: Wang Dongsheng-B40534
> > > > > > Cc: Bhushan Bharat-R65777; Wood Scott-B07421; linuxppc-
> > > > > > dev@lists.ozlabs.org
> > > > > > Subject: Re: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20
> > > > > > state and altivec idle
> > > > > >
> > > > > > On Wed, 2013-09-25 at 03:10 -0500, Wang Dongsheng-B40534 wrote:
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Bhushan Bharat-R65777
> > > > > > > > Sent: Wednesday, September 25, 2013 2:23 PM
> > > > > > > > To: Wang Dongsheng-B40534; Wood Scott-B07421
> > > > > > > > Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> > > > > > > > Subject: RE: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20
> > > > > > > > state and altivec idle
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Linuxppc-dev [mailto:linuxppc-dev-
> > > > > > > > > bounces+bharat.bhushan=freescale.com@lists.ozlabs.org] On
> > > > > > > > > bounces+Behalf Of Dongsheng
> > > > > > > > > Wang
> > > > > > > > > Sent: Tuesday, September 24, 2013 2:59 PM
> > > > > > > > > To: Wood Scott-B07421
> > > > > > > > > Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> > > > > > > > > Subject: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20
> > > > > > > > > state and altivec idle
> > > > > > > > >
> > > > > > > > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > > > > > > >
> > > > > > > > > Add a sys interface to enable/diable pw20 state or altivec
> > > > > > > > > idle, and control the wait entry time.
> > > > > > > > >
> > > > > > > > > Enable/Disable interface:
> > > > > > > > > 0, disable. 1, enable.
> > > > > > > > > /sys/devices/system/cpu/cpuX/pw20_state
> > > > > > > > > /sys/devices/system/cpu/cpuX/altivec_idle
> > > > > > > > >
> > > > > > > > > Set wait time interface:(Nanosecond)
> > > > > > > > > /sys/devices/system/cpu/cpuX/pw20_wait_time
> > > > > > > > > /sys/devices/system/cpu/cpuX/altivec_idle_wait_time
> > > > > > > > > Example: Base on TBfreq is 41MHZ.
> > > > > > > > > 1~47(ns): TB[63]
> > > > > > > > > 48~95(ns): TB[62]
> > > > > > > > > 96~191(ns): TB[61]
> > > > > > > > > 192~383(ns): TB[62]
> > > > > > > > > 384~767(ns): TB[60]
> > > > > > > > > ...
> > > > > > > > >
> > > > > > > > > Signed-off-by: Wang Dongsheng
> > > > > > > > > <dongsheng.wang@freescale.com>
> > > > > > > > > ---
> > > > > > > > > *v4:
> > > > > > > > > Move code from 85xx/common.c to kernel/sysfs.c.
> > > > > > > > >
> > > > > > > > > Remove has_pw20_altivec_idle function.
> > > > > > > > >
> > > > > > > > > Change wait "entry_bit" to wait time.
> > > > > > > > >
> > > > > > > > >  arch/powerpc/kernel/sysfs.c | 291
> > > > > > > > > ++++++++++++++++++++++++++++++++++++++++++++
> > > > > > > > >  1 file changed, 291 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/arch/powerpc/kernel/sysfs.c
> > > > > > > > > b/arch/powerpc/kernel/sysfs.c index 27a90b9..23fece6
> > > > > > > > > 100644
> > > > > > > > > --- a/arch/powerpc/kernel/sysfs.c
> > > > > > > > > +++ b/arch/powerpc/kernel/sysfs.c
> > > > > > > > > @@ -85,6 +85,279 @@ __setup("smt-snooze-delay=",
> > > > > > > > > setup_smt_snooze_delay);
> > > > > > > > >
> > > > > > > > >  #endif /* CONFIG_PPC64 */
> > > > > > > > >
> > > > > > > > > +#ifdef CONFIG_FSL_SOC
> > > > > > > > > +#define MAX_BIT		63
> > > > > > > > > +
> > > > > > > > > +static u64 pw20_wt;
> > > > > > > > > +static u64 altivec_idle_wt;
> > > > > > > > > +
> > > > > > > > > +static unsigned int get_idle_ticks_bit(u64 ns) {
> > > > > > > > > +	u64 cycle;
> > > > > > > > > +
> > > > > > > > > +	cycle = div_u64(ns, 1000 / tb_ticks_per_usec);
> > > > > > > >
> > > > > > > > When tb_ticks_per_usec  > 1000 (timebase frequency > 1GHz)
> > > > > > > > then this will always be ns, which is not correct, no?
> > > > > >
> > > > > > Actually it'll be a divide by zero in that case.
> > > > > >
> > > > > tb_ticks_per_usec = ppc_tb_freq / 1000000; Means TB freq should be
> > > > > more than 1MHZ.
> > > > >
> > > > > if ppc_tb_freq less than 1000000, the tb_ticks_per_usec will be a
> > > > > divide by zero.
> > > > > If this condition is established, I think kernel cannot work as a
> > > > normal.
> > > > >
> > > > > So I think we need to believe that the variable is not zero.
> > > >
> > > > We do believe it is non-zero but greater than 1000 :)
> > > >
> > > > > And I think TB freq
> > > > > should not less than 1MHZ on PPC platform, because if TB freq less
> > > > > than 1MHZ, the precision time will become very poor and system
> > > > > response time will be slower.
> > > >
> > > > Not sure what you are describing here related to divide by zero we
> > > > are mentioning.
> > > > You are talking about if tb_ticks_per_usec is ZERO and we are
> > > > talking about if (1000/tb_ticks_per_usec) will be zero.
> > > >
> > > > BTW, div_u64() handle the case where divider is zero.
> > 
> > How?  When I checked yesterday it looked like div_u64() mapped to a
> > hardware division on 64-bit targets.  In any case it's not good to rely
> > on such behavior.
> > 
> > > cycle = div_u64(ns, 1000 / tb_ticks_per_usec); For this, I think we
> > > were discussing the two issues:
> > >
> > > 1. Scott talking about, when the tb_ticks_per_usec is a zero.
> > 
> > No I wasn't.  I was talking about when tb_ticks_per_usec > 1000, and thus
> > "1000 / tb_ticks_per_usec" is zero.  You said that the result would be ns
> > in that case.
> > 
> > > 2. You are talking about 1000/tb_ticks_per_usec is a zero.
> > > This situation is about TB freq > 1GHZ.
> > >
> > > I will fix this issue. Like I said before, "If timebase frequency >
> > > 1GHz, this should be "tb_ticks_per_usec / 1000" and to get
> > tb_ticks_per_nsec.
> > > This should be changed to "cycle = ns * tb_ticks_per_nsec;""
> > >
> > > #define TB_FREQ_1GHZ	1000
> > >
> > > If (tb_ticks_per_usec > TB_FREQ_1GHZ)
> > > 	cycle = ns * (tb_ticks_per_usec / 1000); else
> > > 	cycle = div_u64(ns, 1000 / tb_ticks_per_usec);
> > >
> > > how about this? :)
> > 
> > I suggested an alternative to satisfy your complaint that it's hard to
> > test one of those if/else branches.
> > 
> > Plus, your version will be quite inaccurate if (e.g.) tb_ticks_per_usec
> > is 501, or 1999.
> > 
> cycle = div_u64(ns * tb_ticks_per_usec, 1000); It's look good.
> But why we need:
> 	if (ns >= 10000)
> 		cycle = ((ns + 500) / 1000) * tb_ticks_per_usec;
> ?
> 
> I think "cycle = div_u64(ns * tb_ticks_per_usec, 1000)" is good enough. :)

It's to deal with overflow if a very large value of ns is provided
(and/or tb_ticks_per_usec is larger than we expect).

-Scott
