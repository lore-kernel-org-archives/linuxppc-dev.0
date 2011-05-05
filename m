Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B15451007D1
	for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2011 08:29:31 +1000 (EST)
Subject: Re: [RFC][PATCH] powerpc: respect how command line nr_cpus is set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <B122211D-FA1E-4B0D-8399-6EC4F701FCDF@kernel.crashing.org>
References: <1304540257-19831-1-git-send-email-galak@kernel.crashing.org>
	<1304562302.2513.418.camel@pasglop>
	<B122211D-FA1E-4B0D-8399-6EC4F701FCDF@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 06 May 2011 08:29:23 +1000
Message-ID: <1304634563.2513.453.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> From Documentation/kernel-parameters.txt:
> 
>         nr_cpus=        [SMP] Maximum number of processors that an SMP kernel
>                         could support.  nr_cpus=n : n >= 1 limits the kernel to
>                         supporting 'n' processors. Later in runtime you can not
>                         use hotplug cpu feature to put more cpu back to online.
>                         just like you compile the kernel NR_CPUS=n
> 
> Which makes me think we should have max_cpus be an absolute limit.

Ok, looks like I've been confusing nr_cpus= vs. max_cpus= or something
like that.

I'll have a look at your patch later today.

Cheers,
Ben.
