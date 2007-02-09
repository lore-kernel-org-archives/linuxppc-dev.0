Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 19ED7DDEBF
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 09:25:53 +1100 (EST)
Message-ID: <45CCF4EF.9050507@smiths-aerospace.com>
Date: Fri, 09 Feb 2007 17:25:51 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: "Morrison, Tom" <tmorrison@empirix.com>
Subject: Re: device tree / how to build/compile & use with u-boot to boot
	uImage?
References: <BD261180E6D35F4D9D32F3E44FD3D901066B2252@EMPBEDEX.empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D901066B2252@EMPBEDEX.empirix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Morrison, Tom wrote:
> All,
> 
> Sorry for my ignorance here, but we have upgraded our kernel from
> 2.6.11.xx to 2.6.20-rcx (using a specific git-branch for the mpc85xx) 
> to run on the MPC8548CDS eval board (using default options provided 
> by this branch for this eval board). I successfully compiled/loaded the 
> uImage, but it hangs after decompression (with root=/dev/nfs)
> 
> Also, I was told to upgrade our u-boot source code (with another git 
> branch for to the mpc85xx) and successfully get to the u-boot prompt.
> 
> From googling through the lists - it seems that I need to build a 
> device tree blob and pass that device tree to the kernel in some
> fashion? 
> 
> I tried to compile the default dts image (using the dtc compiler 
> installed by LTIB), but it is complaining about no '/chosen' in 
> the definition:
> 
>   <path>/dtc -I dts -O dtb - -o mpc8548cds.dtb -V 16 dts/mpc8548cds.dts

Trivia: the no "/chosen" warning can be ignored.  The u-boot command 
"bootm" generates the "/chosen" branch when you run the command and it 
boots linux.

Note: You want version 16 (or better?) for the fdt blob.  I believe the 
dtc defaults to this now, but it wasn't always that way.

[snip - others have chimed in]

> Tom Morrison
> Principal Software Engineer

gvb
