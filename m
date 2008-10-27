Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 3A00CDDE11
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 12:33:21 +1100 (EST)
Message-ID: <490527CF.80908@hypersurf.com>
Date: Sun, 26 Oct 2008 18:30:39 -0800
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
References: <1224863858-7933-1-git-send-email-galak@kernel.crashing.org>	<20081024.161813.193686281.davem@davemloft.net>	<1224970389.7654.473.camel@pasglop>
	<4903A37A.50607@hypersurf.com> <1225003723.7654.490.camel@pasglop>
In-Reply-To: <1225003723.7654.490.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>>What does this all mean to my GigE (dual 1.1 GHz 7455s)? Is this
>>thing supposed to be able to spread irq between its cpus?
> 
> 
> Depends on the interrupt controller. I don't know that machine
> but for example the Apple Dual G5's use an MPIC that can spread
> based on an internal HW round robin scheme. This isn't always
> the best idea tho for cache reasons... depends if an at what level
> your caches are shared between CPUs.
> 
> Ben.
> 
Sorry. I thought GigE was a common name for the machine. It is a dual
450 MHz G4 powermac with a gigabit ethernet and AGP. It now has a
PowerLogix dual 1.1 GHz 7455 in it. I think the L3 caches are
seperate? Not sure about the original cpu card. Can the OS tell?

The reason I asked is that I seem to remember a config option that
would restrict the irqs to cpu 0? Help suggested it was needed for
certain PowerMacs. Didn't provide any help as to which ones. My GigE
currently spreads them between the two. I have not noticed any
additional holes in the space time contiuum.

kevin
