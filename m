Return-Path: <hollis@penguinppc.org>
In-Reply-To: <20050519131844.7D707C1512@atlas.denx.de>
References: <20050519131844.7D707C1512@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6fcc07be88e5091ac1428e9bbde6d92f@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Thu, 19 May 2005 22:51:56 -0500
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org,
	u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Subject: Re: [U-Boot-Users] RFC: Booting the Linux/ppc64 kernel without Open
	Firmware HOWTO (#2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On May 19, 2005, at 8:18 AM, Wolfgang Denk wrote:
>
> But my biggest concern is that we  should  try  to  come  up  with  a
> solution  that  has  a  wider  acceptance. Especially from the U-Boot
> point of view it is not exactly nice that each of  PowerPC,  ARM  and
> MIPS  use  their very own, completely incompatible way of passing in-
> formation from the boot loader to the kernel.
>
> As is, your proposal will add just another incompatible way of  doing
> the  same  thing  (of course we will have to stay backward compatible
> with U-Boot to allow booting older kernels, too).
>
> Why don't we try to come up with a solution that is acceptable to the
> other architectures as well?
>
> Maybe you want  to  post  the  RFC  to  lkml,  or  at  least  to  the
> linux-arm-kernel and linux-mips mailing lists?

As you observe, having multiple incompatible communication mechanisms 
is an issue of u-boot code maintenance. Since you are the most affected 
party, perhaps you could propose something for all the architectures? 
You're obviously much more in tune with the needs of ARM and MIPS...

In the meantime, it sounds like this device tree stuff solves ppc64's 
problem in a way the maintainers are happy with, so it's hard to ask 
them to come up with a solution to a problem they don't have.

-Hollis
