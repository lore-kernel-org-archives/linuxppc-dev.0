Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D41E2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 06:23:35 +1100 (EST)
Received: from mail131-db8 (localhost [127.0.0.1])	by
 mail131-db8-R.bigfish.com (Postfix) with ESMTP id 22FAB4E01D6	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 19:23:30 +0000 (UTC)
Received: from DB8EHSMHS001.bigfish.com (unknown [10.174.8.232])	by
 mail131-db8.bigfish.com (Postfix) with ESMTP id A02E4380088	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 19:23:26 +0000 (UTC)
Message-ID: <1382124202.7979.886.camel@snotra.buserror.net>
Subject: Re: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Fri, 18 Oct 2013 14:23:22 -0500
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259010B3391@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1381828871-17110-1-git-send-email-dongsheng.wang@freescale.com>
 <1381828871-17110-4-git-send-email-dongsheng.wang@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C08E4@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B1799@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C3279@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B189E@039-SN2MPN1-021.039d.mgd.msft.net>
 <1382028703.7979.782.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B3391@039-SN2MPN1-021.039d.mgd.msft.net>
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

On Thu, 2013-10-17 at 21:36 -0500, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, October 18, 2013 12:52 AM
> > To: Wang Dongsheng-B40534
> > Cc: Bhushan Bharat-R65777; Wood Scott-B07421; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
> > altivec idle
> > 
> > On Thu, 2013-10-17 at 00:51 -0500, Wang Dongsheng-B40534 wrote:
> > >
> > > > -----Original Message-----
> > > > From: Bhushan Bharat-R65777
> > > > Sent: Thursday, October 17, 2013 11:20 AM
> > > > To: Wang Dongsheng-B40534; Wood Scott-B07421
> > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state
> > > > and altivec idle
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Wang Dongsheng-B40534
> > > > > Sent: Thursday, October 17, 2013 8:16 AM
> > > > > To: Bhushan Bharat-R65777; Wood Scott-B07421
> > > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state
> > > > > and altivec idle
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Bhushan Bharat-R65777
> > > > > > Sent: Thursday, October 17, 2013 1:01 AM
> > > > > > To: Wang Dongsheng-B40534; Wood Scott-B07421
> > > > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20
> > > > > > state and altivec idle
> > > > > >
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Wang Dongsheng-B40534
> > > > > > > Sent: Tuesday, October 15, 2013 2:51 PM
> > > > > > > To: Wood Scott-B07421
> > > > > > > Cc: Bhushan Bharat-R65777; linuxppc-dev@lists.ozlabs.org; Wang
> > > > > > Dongsheng-B40534
> > > > > > > Subject: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state
> > > > > > > and
> > > > > > altivec idle
> > > > > > >
> > > > > > > +static ssize_t show_pw20_wait_time(struct device *dev,
> > > > > > > +				struct device_attribute *attr, char *buf) {
> > > > > > > +	u32 value;
> > > > > > > +	u64 tb_cycle;
> > > > > > > +	s64 time;
> > > > > > > +
> > > > > > > +	unsigned int cpu = dev->id;
> > > > > > > +
> > > > > > > +	if (!pw20_wt) {
> > > > > > > +		smp_call_function_single(cpu, do_show_pwrmgtcr0, &value,
> > > > 1);
> > > > > > > +		value = (value & PWRMGTCR0_PW20_ENT) >>
> > > > > > > +					PWRMGTCR0_PW20_ENT_SHIFT;
> > > > > > > +
> > > > > > > +		tb_cycle = (1 << (MAX_BIT - value)) * 2;
> > > > > >
> > > > > > Is value = 0 and value = 1 legal? These will make tb_cycle = 0,
> > > > > >
> > > > > > > +		time = div_u64(tb_cycle * 1000, tb_ticks_per_usec) - 1;
> > > > > >
> > > > > > And time = -1;
> > > > > >
> > > > > Please look at the end of the function, :)
> > > > >
> > > > > "return sprintf(buf, "%llu\n", time > 0 ? time : 0);"
> > > >
> > > > I know you return 0 if value = 0/1, my question was that, is this
> > > > correct as per specification?
> > > >
> > > > Ahh, also for "value" upto 7 you will return 0, no?
> > > >
> > > If value = 0, MAX_BIT - value = 63
> > > tb_cycle = 0xffffffff_ffffffff,
> > 
> > Actually, tb_cycle will be undefined because you shifted a 32-bit value
> > (1) by more than 31 bits.  s/1/1ULL/
> > 
> Actually, we have been discussing this situation that could not have happened.
> See !pw20_wt branch, this branch is read default wait bit.
> The default wait bit is 50, the time is about 1ms.
> The default wait bit cannot less than 50, means the wait entry time cannot greater than 1ms.
> We have already begun benchmark test, and we got a preliminary results.
> 55, 56, 57bit looks good, but we need more benchmark to get the default bit.

What does the default have to do with it?  The user could have set a
different value, and then read it back.

Plus, how much time corresponds to bit 50 depends on the actual timebase
frequency which could vary.

-Scott
