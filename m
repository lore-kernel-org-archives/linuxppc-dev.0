Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94DC5B7CF2
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 14:29:48 +1100 (EST)
Subject: Re: [PATCH] perf_event: e500 support
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4B7349F2.8030802@freescale.com>
Date: Wed, 17 Feb 2010 21:29:39 -0600
Message-Id: <2E4FC058-0455-4467-BDE4-BFB18EDCA059@kernel.crashing.org>
References: <20100115214351.GA2869@loki.buserror.net>
	<20100210222932.GA9844@brick.ozlabs.ibm.com>
	<4B7349F2.8030802@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 10, 2010, at 6:06 PM, Scott Wood wrote:

>>> 
>>> --- a/arch/powerpc/kernel/Makefile
>>> +++ b/arch/powerpc/kernel/Makefile
>>> @@ -98,7 +98,10 @@ obj64-$(CONFIG_AUDIT)		+= compat_audit.o
>>>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
>>> obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
>>> -obj-$(CONFIG_PPC_PERF_CTRS)	+= perf_event.o perf_callchain.o
>>> +obj-$(CONFIG_PPC_PERF_CTRS)	+= perf_event.o
>>> +obj-$(CONFIG_FSL_EMB_PERF_EVENT) += perf_event_fsl_emb.o
>>> +obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o
>>> +obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
>> This is because we want perf_callchain.o even if we don't have
>> hardware PMU support, is it?  If so this is a separate fix that
>> deserves its own patch.
> 
> OK.

You going to repost with this broken up into two patches?

- k
