Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070514004014.GF6517@localhost.localdomain>
References: <20070512004605.GA2808@mag.az.mvista.com>
	<20070512005735.GJ3365@mag.az.mvista.com>
	<20070514004014.GF6517@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <13fe8e1b864142e1fdf766524eede73d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/13] powerpc: check cache coherency of kernel vs firmware
Date: Mon, 14 May 2007 14:34:49 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> check_cache_coherency() verifies that the cache coherency setting of
>> the kernel (CONFIG_NOT_COHERENT_CACHE) matches that left by the 
>> firmware,
>> as indicated by coherency-off device tree property.
>
> This looks really bogus.  If the firmware reports a coherency state,
> then presumably there's some hardware switch to turn coherency on or
> off.  In which case, can't the kernel just toggle that switch to
> whatever's appropriate for it?

But can the kernel know in all cases what is the
appropriate setting?  This kind of thing is a
typical firmware job.


Segher
