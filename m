Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 38E6667B1A
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 16:06:18 +1000 (EST)
In-Reply-To: <453771E5.4090808@bplan-gmbh.de>
References: <453771E5.4090808@bplan-gmbh.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
Date: Fri, 20 Oct 2006 01:06:14 -0500
To: Nicolas DET <nd@bplan-gmbh.de>
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com, sl@bplan-gmbh.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 19, 2006, at 7:39 AM, Nicolas DET wrote:

> This 'big' patch adds support for CHRP/MPC52xx based platform.  
> Here, this is the bPlan's Efika computer (http://www.bplan-gmbh.de/ 
> efika_spec_en.html)
>
> We know this patch is not totaly compliant with Documentation/ 
> CodingStyle/.
>
> We would like people to comment and review it. This way we would  
> provide a new patch with the changes required (if any) for an  
> upcomming merge in the kernel.
>
> This patch has been applied on the kernel 2.6.18.1.
>
> Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>
> Signed-off-by: Sven Luther <sl@bplan-gmbh.de>

I think it would be extremely useful to get a dump of what the device- 
tree looks like.  We have to be very careful to device nodes for 52xx  
components are competed consistent between this 'CHRP' style and a  
more embedded 52xx boards.

Some high level comments:
1. lets stick with the 52xx naming, instead of 5k2
2. PIC code needs to be updated for new interrupt model (as well as  
remove of pt_regs)
3. use standard kernel debug macros
4. look at replacing sram_allocator w/rheap

if you repost the patch broken up into driver and platform bits it  
will be easier to provide more detailed comments.

- kumar
