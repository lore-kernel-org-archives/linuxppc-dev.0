Return-Path: <scottwood@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D1FE2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 12:20:26 +1100 (EST)
Received: from mail15-db9 (localhost [127.0.0.1])	by mail15-db9-R.bigfish.com
 (Postfix) with ESMTP id C5D9EC03FF	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Nov 2013 01:20:19 +0000 (UTC)
Received: from DB9EHSMHS015.bigfish.com (unknown [10.174.16.246])	by
 mail15-db9.bigfish.com (Postfix) with ESMTP id 9E8A180082	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 01:20:17 +0000 (UTC)
Message-ID: <1383787214.23598.96.camel@snotra.buserror.net>
Subject: Re: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Wed, 6 Nov 2013 19:20:14 -0600
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259010BD119@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1381828871-17110-1-git-send-email-dongsheng.wang@freescale.com>
 <1381828871-17110-4-git-send-email-dongsheng.wang@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C08E4@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B1799@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C3279@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B189E@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C34C1@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B195F@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C362B@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B33C3@039-SN2MPN1-021.039d.mgd.msft.net>
 <1382124094.7979.885.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BBC86@039-SN2MPN1-021.039d.mgd.msft.net>
 <1383601901.25829.33.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BC83B@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071E442A@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BD119@039-SN2MPN1-021.039d.mgd.msft.net>
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

On Wed, 2013-11-06 at 01:50 -0600, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Bhushan Bharat-R65777
> > Sent: Wednesday, November 06, 2013 1:25 PM
> > To: Wang Dongsheng-B40534; Wood Scott-B07421
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
> > altivec idle
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Wang Dongsheng-B40534
> > > Sent: Tuesday, November 05, 2013 8:40 AM
> > > To: Wood Scott-B07421
> > > Cc: Bhushan Bharat-R65777; linuxppc-dev@lists.ozlabs.org
> > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
> > > altivec idle
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Tuesday, November 05, 2013 5:52 AM
> > > > To: Wang Dongsheng-B40534
> > > > Cc: Wood Scott-B07421; Bhushan Bharat-R65777; linuxppc-
> > > > dev@lists.ozlabs.org
> > > > Subject: Re: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state
> > > > and altivec idle
> > > >
> > > > On Sun, 2013-11-03 at 22:04 -0600, Wang Dongsheng-B40534 wrote:
> > > > > > -----Original Message-----
> > > > > > From: Wang Dongsheng-B40534
> > > > > > Sent: Monday, October 21, 2013 11:11 AM
> > > > > > To: Wood Scott-B07421
> > > > > > Cc: Bhushan Bharat-R65777; linuxppc-dev@lists.ozlabs.org
> > > > > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20
> > > > > > state and altivec idle
> > > > > >
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Wood Scott-B07421
> > > > > > > Sent: Saturday, October 19, 2013 3:22 AM
> > > > > > > To: Wang Dongsheng-B40534
> > > > > > > Cc: Bhushan Bharat-R65777; Wood Scott-B07421; linuxppc-
> > > > > > > dev@lists.ozlabs.org
> > > > > > > Subject: Re: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20
> > > > > > > state and altivec idle
> > > > > > >
> > > > > > > On Thu, 2013-10-17 at 22:02 -0500, Wang Dongsheng-B40534 wrote:
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Bhushan Bharat-R65777
> > > > > > > > > Sent: Thursday, October 17, 2013 2:46 PM
> > > > > > > > > To: Wang Dongsheng-B40534; Wood Scott-B07421
> > > > > > > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > > > > > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for
> > > > > > > > > pw20 state and altivec idle
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > From: Wang Dongsheng-B40534
> > > > > > > > > > > > Sent: Thursday, October 17, 2013 11:22 AM
> > > > > > > > > > > > To: Bhushan Bharat-R65777; Wood Scott-B07421
> > > > > > > > > > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > > > > > > > > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs
> > > > > > > > > > > > for
> > > > > > > > > > > > pw20 state and altivec idle
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > > From: Bhushan Bharat-R65777
> > > > > > > > > > > > > Sent: Thursday, October 17, 2013 11:20 AM
> > > > > > > > > > > > > To: Wang Dongsheng-B40534; Wood Scott-B07421
> > > > > > > > > > > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > > > > > > > > > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add
> > > > > > > > > > > > > sysfs for
> > > > > > > > > > > > > pw20 state and altivec idle
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > > > From: Wang Dongsheng-B40534
> > > > > > > > > > > > > > Sent: Thursday, October 17, 2013 8:16 AM
> > > > > > > > > > > > > > To: Bhushan Bharat-R65777; Wood Scott-B07421
> > > > > > > > > > > > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > > > > > > > > > > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add
> > > > > > > > > > > > > > sysfs for
> > > > > > > > > > > > > > pw20 state and altivec idle
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > > > > From: Bhushan Bharat-R65777
> > > > > > > > > > > > > > > Sent: Thursday, October 17, 2013 1:01 AM
> > > > > > > > > > > > > > > To: Wang Dongsheng-B40534; Wood Scott-B07421
> > > > > > > > > > > > > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > > > > > > > > > > > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add
> > > > > > > > > > > > > > > sysfs for
> > > > > > > > > > > > > > > pw20 state and altivec idle
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > > > > > From: Wang Dongsheng-B40534
> > > > > > > > > > > > > > > > Sent: Tuesday, October 15, 2013 2:51 PM
> > > > > > > > > > > > > > > > To: Wood Scott-B07421
> > > > > > > > > > > > > > > > Cc: Bhushan Bharat-R65777;
> > > > > > > > > > > > > > > > linuxppc-dev@lists.ozlabs.org; Wang
> > > > > > > > > > > > > > > Dongsheng-B40534
> > > > > > > > > > > > > > > > Subject: [PATCH v5 4/4] powerpc/85xx: add
> > > > > > > > > > > > > > > > sysfs for
> > > > > > > > > > > > > > > > pw20 state and
> > > > > > > > > > > > > > > altivec idle
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > From: Wang Dongsheng
> > > > > > > > > > > > > > > > <dongsheng.wang@freescale.com>
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Add a sys interface to enable/diable pw20
> > > > > > > > > > > > > > > > state or altivec idle, and
> > > > > > > > > > > > > > > control the
> > > > > > > > > > > > > > > > wait entry time.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Enable/Disable interface:
> > > > > > > > > > > > > > > > 0, disable. 1, enable.
> > > > > > > > > > > > > > > > /sys/devices/system/cpu/cpuX/pw20_state
> > > > > > > > > > > > > > > > /sys/devices/system/cpu/cpuX/altivec_idle
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Set wait time interface:(Nanosecond)
> > > > > > > > > > > > > > > > /sys/devices/system/cpu/cpuX/pw20_wait_time
> > > > > > > > > > > > > > > > /sys/devices/system/cpu/cpuX/altivec_idle_wa
> > > > > > > > > > > > > > > > it
> > > > > > > > > > > > > > > > _t
> > > > > > > > > > > > > > > > ime
> > > > > > > > > > > > > > > > Example: Base on TBfreq is 41MHZ.
> > > > > > > > > > > > > > > > 1~48(ns): TB[63]
> > > > > > > > > > > > > > > > 49~97(ns): TB[62]
> > > > > > > > > > > > > > > > 98~195(ns): TB[61]
> > > > > > > > > > > > > > > > 196~390(ns): TB[60]
> > > > > > > > > > > > > > > > 391~780(ns): TB[59]
> > > > > > > > > > > > > > > > 781~1560(ns): TB[58] ...
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Signed-off-by: Wang Dongsheng
> > > > > > > > > > > > > > > > <dongsheng.wang@freescale.com>
> > > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > > *v5:
> > > > > > > > > > > > > > > > Change get_idle_ticks_bit function
> > implementation.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > *v4:
> > > > > > > > > > > > > > > > Move code from 85xx/common.c to
> > kernel/sysfs.c.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Remove has_pw20_altivec_idle function.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Change wait "entry_bit" to wait time.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > diff --git a/arch/powerpc/kernel/sysfs.c
> > > > > > > > > > > > > > > > b/arch/powerpc/kernel/sysfs.c
> > > > > > > > > > > > > > > index
> > > > > > > > > > > > > > > > 27a90b9..10d1128 100644
> > > > > > > > > > > > > > > > --- a/arch/powerpc/kernel/sysfs.c
> > > > > > > > > > > > > > > > +++ b/arch/powerpc/kernel/sysfs.c
> > > > > > > > > > > > > > > > @@ -85,6 +85,284 @@
> > > > > > > > > > > > > > > > __setup("smt-snooze-delay=",
> > > > > > > > > > > > > > > setup_smt_snooze_delay);
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >  #endif /* CONFIG_PPC64 */
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > +#ifdef CONFIG_FSL_SOC
> > > > > > > > > > > > > > > > +#define MAX_BIT				63
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +static u64 pw20_wt; static u64
> > > > > > > > > > > > > > > > +altivec_idle_wt;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +static unsigned int get_idle_ticks_bit(u64
> > ns) {
> > > > > > > > > > > > > > > > +	u64 cycle;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	if (ns >= 10000)
> > > > > > > > > > > > > > > > +		cycle = div_u64(ns + 500, 1000) *
> > > > > > > > > tb_ticks_per_usec;
> > > > > > > > > > > > > > > > +	else
> > > > > > > > > > > > > > > > +		cycle = div_u64(ns *
> > > > tb_ticks_per_usec,
> > > > > > > 1000);
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	if (!cycle)
> > > > > > > > > > > > > > > > +		return 0;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	return ilog2(cycle); }
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +static void do_show_pwrmgtcr0(void *val) {
> > > > > > > > > > > > > > > > +	u32 *value = val;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	*value = mfspr(SPRN_PWRMGTCR0); }
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +static ssize_t show_pw20_state(struct
> > > > > > > > > > > > > > > > +device
> > > > *dev,
> > > > > > > > > > > > > > > > +				struct device_attribute
> > > > *attr,
> > > > > > > char
> > > > > > > > > *buf) {
> > > > > > > > > > > > > > > > +	u32 value;
> > > > > > > > > > > > > > > > +	unsigned int cpu = dev->id;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	smp_call_function_single(cpu,
> > > > > > > > > > > > > > > > +do_show_pwrmgtcr0, &value, 1);
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	value &= PWRMGTCR0_PW20_WAIT;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	return sprintf(buf, "%u\n", value ? 1 :
> > > > 0); }
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +static void do_store_pw20_state(void *val) {
> > > > > > > > > > > > > > > > +	u32 *value = val;
> > > > > > > > > > > > > > > > +	u32 pw20_state;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	pw20_state = mfspr(SPRN_PWRMGTCR0);
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	if (*value)
> > > > > > > > > > > > > > > > +		pw20_state |= PWRMGTCR0_PW20_WAIT;
> > > > > > > > > > > > > > > > +	else
> > > > > > > > > > > > > > > > +		pw20_state &= ~PWRMGTCR0_PW20_WAIT;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	mtspr(SPRN_PWRMGTCR0, pw20_state); }
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +static ssize_t store_pw20_state(struct
> > > > > > > > > > > > > > > > +device
> > > > *dev,
> > > > > > > > > > > > > > > > +				struct device_attribute
> > > > *attr,
> > > > > > > > > > > > > > > > +				const char *buf, size_t
> > > > count)
> > > > > > > {
> > > > > > > > > > > > > > > > +	u32 value;
> > > > > > > > > > > > > > > > +	unsigned int cpu = dev->id;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	if (kstrtou32(buf, 0, &value))
> > > > > > > > > > > > > > > > +		return -EINVAL;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	if (value > 1)
> > > > > > > > > > > > > > > > +		return -EINVAL;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	smp_call_function_single(cpu,
> > > > > > > > > > > > > > > > +do_store_pw20_state, &value, 1);
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	return count; }
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +static ssize_t show_pw20_wait_time(struct
> > > > > > > > > > > > > > > > +device
> > > > > > *dev,
> > > > > > > > > > > > > > > > +				struct device_attribute
> > > > *attr,
> > > > > > > char
> > > > > > > > > *buf) {
> > > > > > > > > > > > > > > > +	u32 value;
> > > > > > > > > > > > > > > > +	u64 tb_cycle;
> > > > > > > > > > > > > > > > +	s64 time;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	unsigned int cpu = dev->id;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +	if (!pw20_wt) {
> > > > > > > > > > > > > > > > +		smp_call_function_single(cpu,
> > > > > > > do_show_pwrmgtcr0,
> > > > > > > > > > > > > > > > +&value,
> > > > > > > > > > > > > 1);
> > > > > > > > > > > > > > > > +		value = (value &
> > > > PWRMGTCR0_PW20_ENT) >>
> > > > > > > > > > > > > > > > +
> > > > 	PWRMGTCR0_PW20_ENT_SHIFT;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +		tb_cycle = (1 << (MAX_BIT - value)) *
> > > > 2;
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Is value = 0 and value = 1 legal? These will
> > > > > > > > > > > > > > > make tb_cycle = 0,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > +		time = div_u64(tb_cycle * 1000,
> > > > > > > tb_ticks_per_usec)
> > > > > > > > > - 1;
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > And time = -1;
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > Please look at the end of the function, :)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > "return sprintf(buf, "%llu\n", time > 0 ? time :
> > 0);"
> > > > > > > > > > > > >
> > > > > > > > > > > > > I know you return 0 if value = 0/1, my question
> > > > > > > > > > > > > was that, is this correct as per specification?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Ahh, also for "value" upto 7 you will return 0, no?
> > > > > > > > > > > > >
> > > > > > > > > > > > If value = 0, MAX_BIT - value = 63 tb_cycle =
> > > > > > > > > > > > 0xffffffff_ffffffff, tb_cycle * 1000 will overflow,
> > > > > > > > > > > > but this
> > > > > > > situation is not possible.
> > > > > > > > > > > > Because if the "value = 0" means this feature will
> > > > > > > > > > > > be
> > > > > > "disable".
> > > > > > > > > > > > Now The default wait bit is 50(MAX_BIT - value,
> > > > > > > > > > > > value = 13), the PW20/Altivec Idle wait entry time
> > > > > > > > > > > > is about 1ms, this time is very long for wait idle
> > > > > > > > > > > > time, and it's cannot be increased(means (MAX_BIT
> > > > > > > > > > > > - value)
> > > > > > > > > > > cannot greater than 50).
> > > > > > > > > > >
> > > > > > > > > > > What you said is not obvious from code and so at least
> > > > > > > > > > > write a comment that value will be always >= 13 or
> > > > > > > > > > > value will never be less than < 8 and below
> > > > > > > > > > > calculation will not overflow. may be error out if
> > value is less than 8.
> > > > > > > > > > >
> > > > > > > > > > The "value" less than 10, this will overflow.
> > > > > > > > > > There is not error, The code I knew it could not be less
> > > > > > > > > > than 10, that's why I use the following code. :)
> > > > > > > > >
> > > > > > > > > I am sorry to persist but this is not about what you know,
> > > > > > > > > this is about how code is read and code does not say what
> > > > > > > > > you know, so add a comment at least and error out/warn
> > > > > > > > > when "value" is less than a
> > > > > > > certain number.
> > > > > > > > >
> > > > > > > > Sorry for the late to response the mail. If it caused
> > > > > > > > confusion, we can
> > > > > > > add a comment.
> > > > > > > >
> > > > > > > > How about the following comment?
> > > > > > > > /*
> > > > > > > >  * If the "value" less than 10, this will overflow.
> > > > > > > >  * From benchmark test, the default wait bit will not be set
> > > > > > > > less than
> > > > > > > 10bit.
> > > > > > > >  * Because 10 bit corresponds to the wait entry time is
> > > > > > > > 439375573401999609(ns),
> > > > > > > >  * for wait-entry-idle time this value looks too long, and
> > > > > > > > we cannot use those
> > > > > > > >  * "long" time as a default wait-entry time. So overflow
> > > > > > > > could not have happened
> > > > > > > >  * and we use this calculation method to get wait-entry-idle
> > time.
> > > > > > > >  */
> > > > > > >
> > > > > > > If there's to be a limit on the times we accept, make it
> > explicit.
> > > > > > > Check for it before doing any conversions, and return an error
> > > > > > > if userspace tries to set it.
> > > > > > >
> > > > > > The branch only use to read default wait-entry-time.
> > > > > > We have no limit the user's input, and we can't restrict. Once
> > > > > > the user set the wait-entry-time, the code will do another branch.
> > > > > >
> > > > >
> > > > > Hi scott,
> > > > > Do you have any comments about this patch?
> > > > > I will add the comment and send this patch again.
> > > >
> > > > What do you mean by "and we can't restrict"?  Why not?
> > > >
> > > > Why is it only used to read the default, and not the current value?
> > > >
> > > We already have a variable which value is set by the user, as we have
> > > discussed before.
> > >
> > > When the system boot-up. Before user set the wait-entry-time, we need
> > > to return a default wait-entry-time, if the user read this
> > > sys-interface. The default wait-entry-time is converted by wait-bit.
> > >
> > > Once the user set the sys-interface, a variable will be used to save
> > > it. And when the user read sys-interface we will return back the
> > variable.
> > 
> > While we are not "restricting user defined value" or "define same
> > restriction for user defined and default", can we have only one flow of
> > calculation and setting rather than conditional based on user have set or
> > not set?
> > 
> Yes, we can do that.
> If we want to use one flow to handle it. We should do the following changes:
> 
> #ifdef CONFIG_FSL_SOC
> #include <linux/slab.h>
> #endif

Don't ifdef headers.

> static u64 *pw20_wt;
> static u64 *altivec_idle_wt;
> 
> static ssize_t show_pw20_wait_time(struct device *dev,
>                                 struct device_attribute *attr, char *buf)
> {
> 	return sprintf(buf, "%llu\n", pw20_wt[dev->id]);
> }
> 
> static ssize_t store_pw20_wait_time(struct device *dev,
>                                 struct device_attribute *attr,
>                                 const char *buf, size_t count)
> {
> ...
> pw20_wt[cpu] = value;
> ...
> }
> 
> static ssize_t show_altivec_idle_wait_time(struct device *dev,
>                                 struct device_attribute *attr, char *buf)
> {
> 	return sprintf(buf, "%llu\n", altivec_idle_wt[dev->id]);
> }
> 
> static ssize_t store_altivec_idle_wait_time(struct device *dev,
>                                 struct device_attribute *attr,
>                                 const char *buf, size_t count)
> {
> ...
> altivec_idle_wt[cpu] = value;
> ...
> }
> 
> static void register_cpu_online(unsigned int cpu)
> {
> ...
> #ifdef CONFIG_FSL_SOC
>         u32 value, pw20_value, altivec_value;
>         u64 tb_cycle;
> #endif
> ...
> #ifdef CONFIG_FSL_SOC
>         if (PVR_VER(cur_cpu_spec->pvr_value) == PVR_VER_E6500) {
>                 device_create_file(s, &dev_attr_pw20_state);
>                 device_create_file(s, &dev_attr_pw20_wait_time);
> 
>                 device_create_file(s, &dev_attr_altivec_idle);
>                 device_create_file(s, &dev_attr_altivec_idle_wait_time);
>         }
> 
>         if (!pw20_wt)
>                 pw20_wt = kzalloc(nr_cpu_ids * sizeof(*pw20_wt), GFP_KERNEL);
> 
> 	  if (!altivec_idle_wt)
> 		    altivec_idle_wt = kzalloc(nr_cpu_ids * sizeof(*altivec_idle_wt), GFP_KERNEL);
> 
>         smp_call_function_single(cpu, do_show_pwrmgtcr0, &value, 1);
> 
>         pw20_value = (value & PWRMGTCR0_PW20_ENT) >> PWRMGTCR0_PW20_ENT_SHIFT;
>         tb_cycle = (1 << (MAX_BIT - pw20_value)) * 2;
>         pw20_wt[cpu] = div_u64(tb_cycle * 1000, tb_ticks_per_usec) - 1;
> 
>         altivec_value = (value & PWRMGTCR0_AV_IDLE_CNT) >> PWRMGTCR0_AV_IDLE_CNT_SHIFT;
>         tb_cycle = (1 << (MAX_BIT - altivec_value)) * 2;
>         altivec_idle_wt[cpu] = div_u64(tb_cycle * 1000, tb_ticks_per_usec) - 1;
> #endif
> ...
> }

Move this stuff to its own function.  The only ifdef should be in a
header that provides an inline stub when it's not available.

Could you explain what you're changing and why?  A diff from your
previous patch would help.

-Scott
