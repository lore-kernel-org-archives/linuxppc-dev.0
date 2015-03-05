Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0113.outbound.protection.outlook.com [207.46.100.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA8EB1A0174
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 00:48:36 +1100 (AEDT)
Message-ID: <54F85ECB.3070200@Freescale.com>
Date: Thu, 5 Mar 2015 07:48:59 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Jamal Hadi Salim <jhs@mojatatu.com>, <linuxppc-dev@lists.ozlabs.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Freescale DPAA FMan FLIB(s)
References: <1425534351-1065-1-git-send-email-Emilian.Medve@Freescale.com>
 <54F84CF1.80702@mojatatu.com>
In-Reply-To: <54F84CF1.80702@mojatatu.com>
Content-Type: text/plain; charset="windows-1252"
Cc: Igal Liberman <Igal.Liberman@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Jamal,


On 03/05/2015 06:32 AM, Jamal Hadi Salim wrote:
> On 03/05/15 00:45, Emil Medve wrote:
>> From: Igal Liberman <Igal.Liberman@freescale.com>
>>
>> The Freescale Data Path Acceleration Architecture (DPAA) is a set of
>> hardware components on specific QorIQ P and T series multicore
>> processors.
>> This architecture provides the infrastructure to support simplified
>> sharing of networking interfaces and accelerators by multiple CPU cores,
>> and the accelerators themselves.
>>
>> One of the DPAA accelerators is the Frame Manager (FMan), which
>> combines the Ethernet network interfaces with packet distribution
>> logic to provide intelligent distribution and queuing decisions for
>> incoming traffic at line rate.
>>
>> This patch presents the FMan Foundation Libraries (FLIB) headers.
>> The FMan FLIB suite adds basic support for the DPAA FMan hardware
>> register access.
>> The FMan FLIB suite is used in Freescale's SDK Releases.
>>
> 
> Is this intended to merely enable your sdk?

The intent is to upstream the entire suite of the DPAA drivers. All the
drivers are still WIP, but B/QMan have been already presented to the
upstream community and this is the first attempt to publish (some low
level code of) the FMan driver. As we go through our internal checklist
and in the same time address community feedback we'll soon get the
drivers to be acceptable for the upstream trees

The first version of the actual Ethernet driver will follow imminently

SDK enablement is a side-effect

> How are you planning to
> add support for your classifiers, queue schedulers etc?

Yes

> Is that a patch
> on top of this or it is something that sits on user space?

Both. Full DPAA/Ethernet enablement will be present in the kernel. We
also have support for user-space based approach. I'm unsure where/when
we might publish that. Of course the SDK is always a place you can turn
to for all the code we have (in whatever state it might be)


Cheers.
