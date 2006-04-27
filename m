Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from agrxsusmail.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 171A467A3B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 06:31:19 +1000 (EST)
Message-ID: <44511C88.1010107@smiths-aerospace.com>
Date: Thu, 27 Apr 2006 15:33:28 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
Subject: Re: FT u-boot shim
References: <20060427190547.1DD90353DAC@atlas.denx.de>
	<D358E665-60E4-48C0-82FD-7A1C16DAF00C@kernel.crashing.org>
In-Reply-To: <D358E665-60E4-48C0-82FD-7A1C16DAF00C@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: U-Boot Users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> Let's say we have to support such situations, too.
>>
>>> * dts owned by u-boot??
>> I'm not sure about this. I tend to believe the  dts  belongs  to  the
>> kernel.
>>
>>> Some questions/issues:
>>> * ownership of .dts is problematic.  I hate having a file duplicated
>>> by both u-boot and kernel.  However it also seems bad to make the
>>> build of either depend on the user grabbing a dts from some third
>>> party.  Ideas?  A concrete example would be the MPC8349 ADS/SYS/MDS
>>> port.  Boards ship with an "old" u-boot, thus we need a kernel
>>> wrapper with .dts.  However, newer u-boot's can (hopefully will) have
>>> a dts in them
>> Can we provide the dts as a separate blob that gets  built  with  the
>> kernel image? From U-Boot's point of view, this could be a multi-file
>> image  which  combines  the  dts and the kernel into a single file so
>> that users don't have to care much about this.
> 
> The problem is that there are somethings that u-boot knows that needs  
> to go into the blob (memory size, boot args, initrd info,  
> frequencies, etc.)

[snip]

> - kumar

A thought that keeps recurring (but I've suppressed because I don't have 
time to play...) is that it would be Really Cool[tm] to store the u-boot 
env variables in a flat tree and then pass the env/tree to linux.  It 
also sounds like a major change & disruption to u-boot :-(.  I haven't 
looked at what it would do to code size either.

U-boot could then be a better OpenBoot than OpenBoot ;-)

gvb
