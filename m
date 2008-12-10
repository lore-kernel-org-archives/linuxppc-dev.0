Return-Path: <galak@kernel.crashing.org>
Message-Id: <09D94812-E541-4BE5-B679-0036F23E33D9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
In-Reply-To: <493FCB98.7000803@aimvalley.nl>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: some (MPC8313) Freescale patches not in latest kernel
Date: Wed, 10 Dec 2008 10:42:29 -0600
References: <493FCB98.7000803@aimvalley.nl>
Cc: linuxppc-dev@ozlabs.org, LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 10, 2008, at 8:00 AM, Norbert van Bolhuis wrote:

>
> I'm preparing the latest (2.6.28-rc7) linux kernel for an MPC8313  
> based project
> that's about to start.
>
> Things seems to work great with the base 2.6.28-rc7 kernel. On our  
> MPC8313E-RDB
> the kernel boots without problems, ethernet (with eTSEC2/eth1) works  
> and even
> eTSEC1/eth0 has a 1gbit link. Most other peripherals seems to work  
> as well, I never
> really tried them though.
>
> However, the Freescale MPC8313 BSP (and http://www.bitshrine.org/ 
> gpp/) includes a few
> patches which I believe I need and/or are useful, for instance:
> linux-fsl-2.6.23-MPC8313ERDB-ETSEC27-errata-workaround.patch
> linux-fsl-2.6.23-MPC8313ERDB-IEEE-1588.patch
> linux-fsl-2.6.23-GIANFAR_PARAMETER_ADJUST.patch
> linux-fsl-2.6.23-GIANFAR_SKB_BUFFER_RECYCLING_SUPPORT.patch
> linux-fsl-2.6.23-GIANFAR_SKB_BUFFER_RECYCLING_SUPPORT-2.patch
>
> These patches are not in the latest (2.6.28-rc7) linux kernel
> nor in any of the powerpc devlopment trees
> (e.g. git://git.kernel.org/pub/scm/linux/kernel/git/paulus/ 
> powerpc.git)
> Of course users like me can simply check out the patches and apply  
> them
> if needed for the project.
> Before I do that I would just like to understand why they're not in.
> They're not MPC8313(-RDB) specific and they seem very useful to me.
>
> Is it lack of time/importance ?

Simply put the reason is that some of these patches have never been  
posted to the open source for acceptance into the kernel.  I would  
suggest requesting that of Freescale through whatever sales contact  
you have.

- k
