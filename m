Return-Path: <mingo@elte.hu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BF1FEB71EF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 00:27:30 +1000 (EST)
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5293BDDDB6
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 00:27:29 +1000 (EST)
Date: Wed, 17 Jun 2009 16:27:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/6] perf_counter: powerpc: Enable use of software
	counters on 32-bit powerpc
Message-ID: <20090617142719.GC6846@elte.hu>
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
	<20090617142151.GB6846@elte.hu>
	<8C6954A9-BE4C-47F5-AD87-A1D0EAF43F8A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8C6954A9-BE4C-47F5-AD87-A1D0EAF43F8A@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Kumar Gala <galak@kernel.crashing.org> wrote:

> On Jun 17, 2009, at 9:21 AM, Ingo Molnar wrote:
>
>> * Paul Mackerras <paulus@samba.org> wrote:
>>
>>> This depends on the generic atomic64_t patches, which are now in 
>>> Linus' tree.  Ingo, if you're putting these in, please pull 
>>> Linus' tree in first.
>>
>> Note, i've created a new branch, tip:perfcounters/powerpc, so we 
>> can keep these things separate and Ben can pull them too. I see 
>> there was some review feedback - do you want to send a v2 version 
>> perhaps?
>
> Out of interest, is the intent to try and get these changes into 
> .31?  I ask because I want to know if I should try to find time to 
> add support for the FSL embedded perfmon ASAP or not.

I think it would be nice to have more platform support in .31. 
Perfcounters is a brand-new feature so there's no risk of 
regression. In the end it will depend on Linus to pull of course, 
and BenH can veto it too if he'd like no more PowerPC changes in 
this cycle. Worst-case it's all .32 material.

	Ingo
