Return-Path: <jdl@freescale.com>
Message-ID: <4926C8C2.60802@freescale.com>
Date: Fri, 21 Nov 2008 08:42:10 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: nanda <nanda74pg@rediffmail.com>
Subject: Re: Re :Re: [Ltib] ltib error -linux2.6.20.6 with MPC8360E MDS
References: <DFTSgh6rR4.old.1227276970.57828@webmail.rediffmail.com>
In-Reply-To: <DFTSgh6rR4.old.1227276970.57828@webmail.rediffmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev@ozlabs.org, Ltib@nongnu.org, seh@zee2.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

nanda wrote:
> Hi Stuart,
>    Thanks for the information.   gpp access was resolved.
>    I was successful in building the linux 2.6.11 using the ltib and able 
> to bring up the MPC8360 EMDS.
> But, I still face the problem for linux kernel 2.6.19 and 2.6.20.   When 
> I tried using ltib in the bringing up the board. 
>   The MPC 8360 board keeps rebooting after downloading the image Power 
> PC Kernel Image(uImage) and Power PC RAMDisk 
> Image(rootfs.ext2.gz.uboot)  build by the "ltib" 
>     Please clarrify on the same.
> 

I'm not a kernel expert and don't know what failure you
are seeing here, but I might observe that 2.6.19 and .20
are two years old, and 2.6.11 is more than 3 years old.

If you think we, collectively, haven't improved things in
that time period, please, complain about 2.6.11, .19, and .20.

If on the off chance you think things *might* have gotten
better due to a *bit* of development effort over the past
three years, you might try installing a modern U-Boot and
a modern Kernel.

Thanks,
jdl
