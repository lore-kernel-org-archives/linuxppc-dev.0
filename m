Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B9912C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 11:44:26 +1000 (EST)
Message-ID: <5011F25B.7080103@freescale.com>
Date: Thu, 26 Jul 2012 20:43:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v8 0/7] power management patch set
References: <1342788159-27529-1-git-send-email-chenhui.zhao@freescale.com>
 <CADRPPNSw5Yn7EgHt5fm2vYr+zxC4T+JbsvT812u2JPKELNcA6g@mail.gmail.com>
In-Reply-To: <CADRPPNSw5Yn7EgHt5fm2vYr+zxC4T+JbsvT812u2JPKELNcA6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/26/2012 09:02 AM, Li Yang wrote:
> On Fri, Jul 20, 2012 at 8:42 PM, Zhao Chenhui
> <chenhui.zhao@freescale.com> wrote:
>> Changes for v8:
>> * Separated the cpu hotplug patch into three patches, as follows
>>   [PATCH v8 1/7] powerpc/smp: use a struct epapr_spin_table to replace macros
>>   [PATCH v8 2/7] powerpc/smp: add generic_set_cpu_up() to set cpu_state as CPU_UP_PREPARE
>>   [PATCH v8 4/7] powerpc/85xx: add HOTPLUG_CPU support
>>
>> * Replaced magic numbers with macros in "[PATCH 5/7] powerpc/85xx: add sleep and deep sleep support"
>>
>> * no change to the rest of the patch set
> 
> Hi Kumar,
> 
> How about picking about this series for 3.6?  The review seems to
> settle down for this revision.
> 
> 
> Hi Scott,
> 
> Thanks for the review comments provided.  We'd like to get the ACK
> from you for the series if you can.

I ACKed v7; I assume v8 hasn't made anything worse. :-)

I think it's time to merge this, and deal with any issues as they come up.

-Scott
