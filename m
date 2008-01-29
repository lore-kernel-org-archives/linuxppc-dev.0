Return-Path: <galak@kernel.crashing.org>
Message-Id: <D75C469F-CF1E-4E62-AEBD-6D7A65F8D78B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080129054708.GB6422@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] 85xx: some minor cleanups for stx_gp3 and
	tqm85xx
Date: Tue, 29 Jan 2008 00:24:23 -0600
References: <Pine.LNX.4.64.0801251039220.17501@blarg.am.freescale.net>
	<20080129054708.GB6422@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 28, 2008, at 11:47 PM, David Gibson wrote:

> On Fri, Jan 25, 2008 at 10:39:38AM -0600, Kumar Gala wrote:
>> * "simple-bus" covers all our needs for of_platform_bus_probe()
>> * make device tree name just 'soc' not 'soc85..'
>
> Getting rid of the device_type="soc" would be nice, too...

Agreed, but one thing at a time.  We need to define a compat that is  
the equivalent of what we are using SoC for today. (simple-bus + the  
range property details on chip registers)  If we can come up with  
something compat name that is defined as such that I'm all for remoing  
device_type=soc.

- k
