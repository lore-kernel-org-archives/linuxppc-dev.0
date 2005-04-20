Return-Path: <glenn@aoi-industries.com>
Received: from vms040pub.verizon.net (vms040pub.verizon.net [206.46.252.40])
	by ozlabs.org (Postfix) with ESMTP id B5F9767A67
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 23:02:30 +1000 (EST)
Received: from [192.168.1.47] ([68.163.130.201])
	by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix
	0.04 (built Dec 24 2004)) with ESMTPA id
	<0IF800I9WUS3FPU1@vms040.mailsrvcs.net> for
	linuxppc-embedded@ozlabs.org; Wed, 20 Apr 2005 07:02:28 -0500 (CDT)
Date: Wed, 20 Apr 2005 08:02:45 -0400
From: Glenn Burkhardt <glenn@aoi-industries.com>
In-reply-to: <42663E71.60005@ybb.ne.jp>
To: Takeharu KATO <takeharu1219@ybb.ne.jp>
Message-id: <200504200802.45998.glenn@aoi-industries.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <20050419013712.AE32FB01E4@loki.aoi-industries.com>
	<42663E71.60005@ybb.ne.jp>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC 44x Watchdog timer
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

After looking at the current BitKeeper 2.4 development tree on 
source.mvista.com, it looks like the use of the hardware watchdog timer was 
discontinued at some point in favor of using the general purpose timer.  The 
watchdog exception interrupt isn't used, and it's only configurable for 
PPC405 (although I think that the technique would work for the whole 4xx 
family).

Or am I misreading the code?

It would also be nice if your patch were applied to the 2.6 kernel tree.

On Wednesday 20 April 2005 07:35 am, Takeharu KATO wrote:
> Hi
>
> IIRC, MontaVistaLinux has this feature.
> As far as I know, I found it in Monta Vista Linux 3 years ago at least.
> I've not checked resent kernel of Monta Vista Linux, so I am sorry if
> it is wrong now.
>
> Glenn Burkhardt wrote:
> > Is there a patch for the built in watchdog timer in the 440GP available
> > anywhere for the 2.4 kernel (viz., ELDK kernels)?
>
> By the way, BOOKE_WDT patch has not been commited to up-stream kernel.
> Matt(or Kumar?), please apply the patch.
>
> Regards,
