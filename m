Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A54B367BBE
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 00:14:14 +1000 (EST)
To: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support 
In-Reply-To: Your message of "Wed, 27 Sep 2006 21:20:35 +0800."
	<4879B0C6C249214CBE7AB04453F84E4D19D866@zch01exm20.fsl.freescale.net>
References: <4879B0C6C249214CBE7AB04453F84E4D19D866@zch01exm20.fsl.freescale.net>
Date: Wed, 27 Sep 2006 09:14:05 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1GSaAn-000340-DD@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day "Li Yang-r58472" mumbled:

> Agreed.  As we are adding more devices to the device tree, we should
> also have a guideline clearly stated for adding new nodes.  
> 
> I'm adding MURAM as a new node under QE bus.  Please comment.
>                 muram@10000 {
>                         device_type = "memory";
>                         ranges = <0 00010000 0000c000>;
> 
>                         data-only@0{
>                                 reg = <0 c000>;
>                         };
>                 };
> 
> - Leo

So, does it make sense for this node to participate in the early scan
of memory available during the early_init_dt_scan_memory() pass?

Out of curiosity, is "data-only" a standard thing, or did you make
that up too?  What's it mean?	

And your patch for this new node introduction will contain
proposed additions to the QE section of the booting-without-of
documentation, right?

Thanks,
jdl
