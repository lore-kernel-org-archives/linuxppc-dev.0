Return-Path: <thomas@net.t-labs.tu-berlin.de>
Received: from mail.net.t-labs.tu-berlin.de (mail.net.t-labs.tu-berlin.de
 [IPv6:2001:470:96b9:4:130:149:220:252])
 by ozlabs.org (Postfix) with ESMTP id A05D52C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 20:17:05 +1100 (EST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: Gianfar driver crashes in Kernel v3.10
From: =?windows-1252?Q?Thomas_H=FChn?= <thomas@net.t-labs.tu-berlin.de>
In-Reply-To: <1381270140.7979.287.camel@snotra.buserror.net>
Date: Fri, 11 Oct 2013 11:17:03 +0200
Message-Id: <B1062BEC-9A3C-49DC-B97A-9E0A6EE9CD49@net.t-labs.tu-berlin.de>
References: <8EF35D6A-A132-458C-A3B4-80D4D2C5BA4C@dai-labor.de>
 <1381270140.7979.287.camel@snotra.buserror.net>
To: Scott Wood <scottwood@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "claudiu.manoil@freescale.com" <claudiu.manoil@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

On 09.10.2013, at 00:09, Scott Wood <scottwood@freescale.com> wrote:

> On Fri, 2013-10-04 at 12:03 +0000, Thomas H=FChn wrote:
>> [code]
>> [ 2671.841927] Oops: Exception in kernel mode, sig: 5 [#1]
>> [ 2671.847141] Freescale P1014
>> [ 2671.849925] Modules linked in: ath9k pppoe ppp_async iptable_nat =
ath9k_common pppox p
>> e xt_tcpudp xt_tcpmss xt_string xt_statistic xt_state xt_recent =
xt_quota xt_pkttype xt_o
>> mark xt_connbytes xt_comment xt_addrtype xt_TCPMSS xt_REDIRECT =
xt_NETMAP xt_LOG xt_IPMAR
>> ms_datafab ums_cypress ums_alauda slhc nf_nat_tftp nf_nat_snmp_basic =
nf_nat_sip nf_nat_r
>> ntrack_sip nf_conntrack_rtsp nf_conntrack_proto_gre nf_conntrack_irc =
nf_conntrack_h323 n
>> compat_xtables compat ath sch_teql sch_tbf sch_sfq sch_red sch_prio =
sch_htb sch_gred sc
>> skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow cls_route =
cls_fw sch_hfsc sch_ing
>> r usb_storage leds_gpio ohci_hcd ehci_platform ehci_hcd sd_mod =
scsi_mod fsl_mph_dr_of gp
>> [ 2671.988946] CPU: 0 PID: 5209 Comm: iftop Not tainted 3.10.13 #2
>> [ 2671.994859] task: c4b22220 ti: c7ff8000 task.ti: c477e000
>> [ 2672.000250] NIP: c018c7a0 LR: c018c794 CTR: c000b070
>> [ 2672.005206] REGS: c7ff9f10 TRAP: 3202   Not tainted  (3.10.13)
>=20
> Trap 0x3202 is a watchdog timer.
>=20
> Did you get a "Bad trap at=85" line before the above dump? =20

I need to setup my test scenario again as I just copied the crash lines =
out of it without saving the full file with all lines.

> Do you have
> any idea why the watchdog would have been armed without =
CONFIG_BOOKE_WDT
> being set? =20

> Is CONFIG_BOOKE_WDT set?
>=20
This config option is not set. Should I try with the CONFIG_BOOK_WDT =
enabled ?

Greetings Thomas

> -Scott
>=20
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
