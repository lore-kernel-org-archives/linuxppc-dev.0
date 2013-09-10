Return-Path: <STFD002@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C8112C0124
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Sep 2013 19:24:45 +1000 (EST)
Message-ID: <522EE551.8030007@freescale.com>
Date: Tue, 10 Sep 2013 12:24:33 +0300
From: Diana Craciun <diana.craciun@freescale.com>
MIME-Version: 1.0
To: Ivan Krivonos <int0dster@gmail.com>
Subject: Re: big latency while under HV
References: <CAF10W3yi6UOjDN+Nh61OvOvVe6+veaFuXuz_Rx=oWsxPVRDYHQ@mail.gmail.com>
In-Reply-To: <CAF10W3yi6UOjDN+Nh61OvOvVe6+veaFuXuz_Rx=oWsxPVRDYHQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Just to be on the same page, are you using the Freescale Embedded 
Hypervisor provided with the Freescale SDK or other embedded hypervisor?

Anyway, the question is not much related with the Linux kernel, so you 
should probably redirect your question to Freescale support. You can 
reach Freescale support at support@freescale.com.

Diana

On 09/09/2013 06:19 PM, Ivan Krivonos wrote:
> Hi,
>
> i`m working on the embedded hypervisor targeting QorIQ platforms (p3041/p4080).
> I have working prototype starting custom RTOS on just single core in the guest
> space. What I see is the big latency (up to 3 times more) in RTOS running atop
> of HV comparing to RTOS running bare-metal. I`m using lmbench utility.
> It shows
>
> nteger mul: 3.48 nanoseconds
> integer div: 30.44 nanoseconds
> integer mod: 13.92 nanoseconds
> int64 bit: 1.75 nanoseconds
> int64 add: 1.42 nanoseconds
> int64 mul: 6.95 nanoseconds
> HV:hvpriv_count 60000
> int64 div: 447.56 nanoseconds
> int64 mod: 385.42 nanoseconds
> float add: 7.12 nanoseconds
> float mul: 6.95 nanoseconds
> float div: 33.05 nanoseconds
> double add: 7.11 nanoseconds
> double mul: 8.70 nanoseconds
> double div: 57.36 nanoseconds
> float bogomflops: 46.98 nanoseconds
> double bogomflops: 73.09 nanoseconds
>
> The bare-metal results are 3x better. Does anybody have any ideas on what
> may be the source of such latency ? I forward all the exceptions to
> the guest w/o
> affecting HV. Only hvpriv is processed, it takes not more than 2 bus cycles.
> Sorry for poor english
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
