Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1F8E2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 06:21:46 +1100 (EST)
Received: from mail170-db9 (localhost [127.0.0.1])	by
 mail170-db9-R.bigfish.com (Postfix) with ESMTP id 7A543420230	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 19:21:41 +0000 (UTC)
Received: from DB9EHSMHS031.bigfish.com (unknown [10.174.16.253])	by
 mail170-db9.bigfish.com (Postfix) with ESMTP id 3BB701600E9	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 19:21:39 +0000 (UTC)
Message-ID: <1382124094.7979.885.camel@snotra.buserror.net>
Subject: Re: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Fri, 18 Oct 2013 14:21:34 -0500
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259010B33C3@039-SN2MPN1-021.039d.mgd.msft.net>
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

On Thu, 2013-10-17 at 22:02 -0500, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Bhushan Bharat-R65777
> > Sent: Thursday, October 17, 2013 2:46 PM
> > To: Wang Dongsheng-B40534; Wood Scott-B07421
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
> > altivec idle
> > 
> > 
> > 
> > > > > -----Original Message-----
> > > > > From: Wang Dongsheng-B40534
> > > > > Sent: Thursday, October 17, 2013 11:22 AM
> > > > > To: Bhushan Bharat-R65777; Wood Scott-B07421
> > > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state
> > > > > and altivec idle
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Bhushan Bharat-R65777
> > > > > > Sent: Thursday, October 17, 2013 11:20 AM
> > > > > > To: Wang Dongsheng-B40534; Wood Scott-B07421
> > > > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20
> > > > > > state and altivec idle
> > > > > >
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Wang Dongsheng-B40534
> > > > > > > Sent: Thursday, October 17, 2013 8:16 AM
> > > > > > > To: Bhushan Bharat-R65777; Wood Scott-B07421
> > > > > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > > > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20
> > > > > > > state and altivec idle
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Bhushan Bharat-R65777
> > > > > > > > Sent: Thursday, October 17, 2013 1:01 AM
> > > > > > > > To: Wang Dongsheng-B40534; Wood Scott-B07421
> > > > > > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > > > > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20
> > > > > > > > state and altivec idle
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Wang Dongsheng-B40534
> > > > > > > > > Sent: Tuesday, October 15, 2013 2:51 PM
> > > > > > > > > To: Wood Scott-B07421
> > > > > > > > > Cc: Bhushan Bharat-R65777; linuxppc-dev@lists.ozlabs.org;
> > > > > > > > > Wang
> > > > > > > > Dongsheng-B40534
> > > > > > > > > Subject: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20
> > > > > > > > > state and
> > > > > > > > altivec idle
> > > > > > > > >
> > > > > > > > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > > > > > > >
> > > > > > > > > Add a sys interface to enable/diable pw20 state or altivec
> > > > > > > > > idle, and
> > > > > > > > control the
> > > > > > > > > wait entry time.
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
> > > > > > > > > 1~48(ns): TB[63]
> > > > > > > > > 49~97(ns): TB[62]
> > > > > > > > > 98~195(ns): TB[61]
> > > > > > > > > 196~390(ns): TB[60]
> > > > > > > > > 391~780(ns): TB[59]
> > > > > > > > > 781~1560(ns): TB[58]
> > > > > > > > > ...
> > > > > > > > >
> > > > > > > > > Signed-off-by: Wang Dongsheng
> > > > > > > > > <dongsheng.wang@freescale.com>
> > > > > > > > > ---
> > > > > > > > > *v5:
> > > > > > > > > Change get_idle_ticks_bit function implementation.
> > > > > > > > >
> > > > > > > > > *v4:
> > > > > > > > > Move code from 85xx/common.c to kernel/sysfs.c.
> > > > > > > > >
> > > > > > > > > Remove has_pw20_altivec_idle function.
> > > > > > > > >
> > > > > > > > > Change wait "entry_bit" to wait time.
> > > > > > > > >
> > > > > > > > > diff --git a/arch/powerpc/kernel/sysfs.c
> > > > > > > > > b/arch/powerpc/kernel/sysfs.c
> > > > > > > > index
> > > > > > > > > 27a90b9..10d1128 100644
> > > > > > > > > --- a/arch/powerpc/kernel/sysfs.c
> > > > > > > > > +++ b/arch/powerpc/kernel/sysfs.c
> > > > > > > > > @@ -85,6 +85,284 @@ __setup("smt-snooze-delay=",
> > > > > > > > setup_smt_snooze_delay);
> > > > > > > > >
> > > > > > > > >  #endif /* CONFIG_PPC64 */
> > > > > > > > >
> > > > > > > > > +#ifdef CONFIG_FSL_SOC
> > > > > > > > > +#define MAX_BIT				63
> > > > > > > > > +
> > > > > > > > > +static u64 pw20_wt;
> > > > > > > > > +static u64 altivec_idle_wt;
> > > > > > > > > +
> > > > > > > > > +static unsigned int get_idle_ticks_bit(u64 ns) {
> > > > > > > > > +	u64 cycle;
> > > > > > > > > +
> > > > > > > > > +	if (ns >= 10000)
> > > > > > > > > +		cycle = div_u64(ns + 500, 1000) *
> > tb_ticks_per_usec;
> > > > > > > > > +	else
> > > > > > > > > +		cycle = div_u64(ns * tb_ticks_per_usec, 1000);
> > > > > > > > > +
> > > > > > > > > +	if (!cycle)
> > > > > > > > > +		return 0;
> > > > > > > > > +
> > > > > > > > > +	return ilog2(cycle);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static void do_show_pwrmgtcr0(void *val) {
> > > > > > > > > +	u32 *value = val;
> > > > > > > > > +
> > > > > > > > > +	*value = mfspr(SPRN_PWRMGTCR0); }
> > > > > > > > > +
> > > > > > > > > +static ssize_t show_pw20_state(struct device *dev,
> > > > > > > > > +				struct device_attribute *attr, char
> > *buf) {
> > > > > > > > > +	u32 value;
> > > > > > > > > +	unsigned int cpu = dev->id;
> > > > > > > > > +
> > > > > > > > > +	smp_call_function_single(cpu, do_show_pwrmgtcr0, &value,
> > > > > > > > > +1);
> > > > > > > > > +
> > > > > > > > > +	value &= PWRMGTCR0_PW20_WAIT;
> > > > > > > > > +
> > > > > > > > > +	return sprintf(buf, "%u\n", value ? 1 : 0); }
> > > > > > > > > +
> > > > > > > > > +static void do_store_pw20_state(void *val) {
> > > > > > > > > +	u32 *value = val;
> > > > > > > > > +	u32 pw20_state;
> > > > > > > > > +
> > > > > > > > > +	pw20_state = mfspr(SPRN_PWRMGTCR0);
> > > > > > > > > +
> > > > > > > > > +	if (*value)
> > > > > > > > > +		pw20_state |= PWRMGTCR0_PW20_WAIT;
> > > > > > > > > +	else
> > > > > > > > > +		pw20_state &= ~PWRMGTCR0_PW20_WAIT;
> > > > > > > > > +
> > > > > > > > > +	mtspr(SPRN_PWRMGTCR0, pw20_state); }
> > > > > > > > > +
> > > > > > > > > +static ssize_t store_pw20_state(struct device *dev,
> > > > > > > > > +				struct device_attribute *attr,
> > > > > > > > > +				const char *buf, size_t count) {
> > > > > > > > > +	u32 value;
> > > > > > > > > +	unsigned int cpu = dev->id;
> > > > > > > > > +
> > > > > > > > > +	if (kstrtou32(buf, 0, &value))
> > > > > > > > > +		return -EINVAL;
> > > > > > > > > +
> > > > > > > > > +	if (value > 1)
> > > > > > > > > +		return -EINVAL;
> > > > > > > > > +
> > > > > > > > > +	smp_call_function_single(cpu, do_store_pw20_state,
> > > > > > > > > +&value, 1);
> > > > > > > > > +
> > > > > > > > > +	return count;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static ssize_t show_pw20_wait_time(struct device *dev,
> > > > > > > > > +				struct device_attribute *attr, char
> > *buf) {
> > > > > > > > > +	u32 value;
> > > > > > > > > +	u64 tb_cycle;
> > > > > > > > > +	s64 time;
> > > > > > > > > +
> > > > > > > > > +	unsigned int cpu = dev->id;
> > > > > > > > > +
> > > > > > > > > +	if (!pw20_wt) {
> > > > > > > > > +		smp_call_function_single(cpu, do_show_pwrmgtcr0,
> > > > > > > > > +&value,
> > > > > > 1);
> > > > > > > > > +		value = (value & PWRMGTCR0_PW20_ENT) >>
> > > > > > > > > +					PWRMGTCR0_PW20_ENT_SHIFT;
> > > > > > > > > +
> > > > > > > > > +		tb_cycle = (1 << (MAX_BIT - value)) * 2;
> > > > > > > >
> > > > > > > > Is value = 0 and value = 1 legal? These will make tb_cycle =
> > > > > > > > 0,
> > > > > > > >
> > > > > > > > > +		time = div_u64(tb_cycle * 1000, tb_ticks_per_usec)
> > - 1;
> > > > > > > >
> > > > > > > > And time = -1;
> > > > > > > >
> > > > > > > Please look at the end of the function, :)
> > > > > > >
> > > > > > > "return sprintf(buf, "%llu\n", time > 0 ? time : 0);"
> > > > > >
> > > > > > I know you return 0 if value = 0/1, my question was that, is
> > > > > > this correct as per specification?
> > > > > >
> > > > > > Ahh, also for "value" upto 7 you will return 0, no?
> > > > > >
> > > > > If value = 0, MAX_BIT - value = 63 tb_cycle = 0xffffffff_ffffffff,
> > > > > tb_cycle * 1000 will overflow, but this situation is not possible.
> > > > > Because if the "value = 0" means this feature will be "disable".
> > > > > Now The default wait bit is 50(MAX_BIT - value, value = 13), the
> > > > > PW20/Altivec Idle wait entry time is about 1ms, this time is very
> > > > > long for wait idle time, and it's cannot be increased(means
> > > > > (MAX_BIT
> > > > > - value)
> > > > cannot greater than 50).
> > > >
> > > > What you said is not obvious from code and so at least write a
> > > > comment that value will be always >= 13 or value will never be less
> > > > than < 8 and below calculation will not overflow. may be error out
> > > > if value is less than 8.
> > > >
> > > The "value" less than 10, this will overflow.
> > > There is not error, The code I knew it could not be less than 10,
> > > that's why I use the following code. :)
> > 
> > I am sorry to persist but this is not about what you know, this is about
> > how code is read and code does not say what you know, so add a comment at
> > least and error out/warn when "value" is less than a certain number.
> > 
> Sorry for the late to response the mail. If it caused confusion, we can add a comment.
> 
> How about the following comment?
> /*
>  * If the "value" less than 10, this will overflow.
>  * From benchmark test, the default wait bit will not be set less than 10bit.
>  * Because 10 bit corresponds to the wait entry time is 439375573401999609(ns),
>  * for wait-entry-idle time this value looks too long, and we cannot use those
>  * "long" time as a default wait-entry time. So overflow could not have happened
>  * and we use this calculation method to get wait-entry-idle time.
>  */

If there's to be a limit on the times we accept, make it explicit.
Check for it before doing any conversions, and return an error if
userspace tries to set it.

-Scott
