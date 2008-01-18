Return-Path: <galak@kernel.crashing.org>
Message-Id: <C1697EF9-4FC3-4CF3-8BCA-76E6EB04E779@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppcdev@lists.qbjnet.com
In-Reply-To: <20080117222624.19372.qmail@kunk.qbjnet.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: L3CR
Date: Thu, 17 Jan 2008 21:41:34 -0600
References: <20080117222624.19372.qmail@kunk.qbjnet.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 17, 2008, at 4:26 PM, linuxppcdev@lists.qbjnet.com wrote:

> It there a l3cr parameter? It's not in the kernel documentation. I'm
> trying to enable L2 and L3 cache on a G4 cpu upgrade board in a  
> powermac.
>
>> From OSX I was able to get the values of:
> l2cr = 0x80000000
> and
> l3cr = 0x9F020300
>
> from a cache config utility. I've seen references to l3cr setting on
> bsd lists but not for linux.
>
> Thanks...

have you looked in /proc/sys/kernel/l[2,3]cr?

(can't remember if we had a l3cr as well)

- k
