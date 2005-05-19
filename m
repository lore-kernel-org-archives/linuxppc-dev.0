Return-Path: <panto@intracom.gr>
Message-ID: <428C91B0.4090702@intracom.gr>
Date: Thu, 19 May 2005 16:16:32 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20050519131844.7D707C1512@atlas.denx.de>
In-Reply-To: <20050519131844.7D707C1512@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc64-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
	u-boot-users@lists.sourceforge.net, linuxppc-dev@ozlabs.org
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

Wolfgang Denk wrote:
> Dear Ben,
> 
> in message <1116478614.918.75.camel@gaston> you wrote:
> 
>>And here is a second draft with more infos.
>>
>>           Booting the Linux/ppc64 kernel without Open Firmware
> 
> 
> Thanks a lot for taking the initiative to come to an agreement  about
> the kernel boot interface.
> 
> I have some concerns about the memory foot print and  increased  boot
> time  that  will  result  from  the proposed solution. There are many
> embedded systems where resources are tight and requirements are  aven
> tighter.  It  would  be probably a good idea to also ask for feedback
> from these folks - for example by posting your RFC on the celinux-dev
> mailing list.
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
> 
> Why don't we try to come up with a solution that is acceptable to the
> other architectures as well? 
> 
> Maybe you want  to  post  the  RFC  to  lkml,  or  at  least  to  the
> linux-arm-kernel and linux-mips mailing lists?
> 

I'm really interested in having this discussion.

I'm forced to maintain my own u-boot based solution for doing this and
I'd be very interested in whatever gets chosen.

IMHO the current mess is considerable, and at this point I wouldn't
really care if the resulting solution is less than optimal, as long
as there is one.

> Best regards,
> 
> Wolfgang Denk
> 

Regards

Pantelis
