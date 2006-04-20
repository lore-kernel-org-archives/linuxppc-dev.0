Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 38B5067A2E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 06:19:31 +1000 (EST)
Date: Thu, 20 Apr 2006 13:20:47 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [patch][rfc]flattened device tree: Passing a dtb (blob) to Linux.
Message-ID: <20060420202047.GA16930@mag.az.mvista.com>
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
	<9B2C87C5-0B69-46E7-B48B-9CDB882836B2@watson.ibm.com>
	<20060413053614.2648467DE3@ozlabs.org>
	<C67D530F-2629-4D6B-986B-0FC7CFE525BF@watson.ibm.com>
	<1144926434.7777.5.camel@localhost.localdomain>
	<2A70CBD7-4A52-4599-8BEF-6AC633F62C83@watson.ibm.com>
	<1144938844.7777.16.camel@localhost.localdomain>
	<1145378886.5314.57.camel@cashmere.sps.mot.com>
	<1145383451.20176.9.camel@localhost.localdomain>
	<1145547747.5314.126.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1145547747.5314.126.camel@cashmere.sps.mot.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 20, 2006 at 10:42:28AM -0500, Jon Loeliger wrote:
> On Tue, 2006-04-18 at 13:04, Michael Ellerman wrote:
> 
> > > OK, I'm back to reading the list and beginning to catch
> > > up some here...
> > > 
> > > Let me see if I understand the consensus and direction:
> > > 
> > >     1) DTC should NOT reserve its own blob space in the
> > >        memory map, as it does for generated ASM code now,
> 
> > > In all of this, I'm on deck for step 1) above.
> 
> I have updated the DTC to have several bug fixes:
> 
>     - asm_emit_cell() little endian bug fix
>     - use two .long and not .quad directives
>     - Eliminate emitting memreserve for blob in ASM output
> 
> These updates are available here:
> 
>     www.jdl.com/git_repos
> and
>     git://ozlabs.org/srv/projects/dtc/dtc.git
> 
> Please verify and let me know of any problems!

Hey John,

I did a quick test and the new dtc seems to work fine for my dts file.

Mark
