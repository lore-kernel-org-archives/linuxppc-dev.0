Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ED399B71B9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 00:24:23 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 39162DDDA2
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 00:24:22 +1000 (EST)
Message-Id: <8C6954A9-BE4C-47F5-AD87-A1D0EAF43F8A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090617142151.GB6846@elte.hu>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 1/6] perf_counter: powerpc: Enable use of software
	counters on 32-bit powerpc
Date: Wed, 17 Jun 2009 09:24:02 -0500
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
	<20090617142151.GB6846@elte.hu>
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


On Jun 17, 2009, at 9:21 AM, Ingo Molnar wrote:

>
> * Paul Mackerras <paulus@samba.org> wrote:
>
>> This depends on the generic atomic64_t patches, which are now in
>> Linus' tree.  Ingo, if you're putting these in, please pull Linus'
>> tree in first.
>
> Note, i've created a new branch, tip:perfcounters/powerpc, so we can
> keep these things separate and Ben can pull them too. I see there
> was some review feedback - do you want to send a v2 version perhaps?

Out of interest, is the intent to try and get these changes into .31?   
I ask because I want to know if I should try to find time to add  
support for the FSL embedded perfmon ASAP or not.

- k
