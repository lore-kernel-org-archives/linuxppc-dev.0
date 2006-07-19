Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CE5D67B32
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 06:54:50 +1000 (EST)
In-Reply-To: <20060719201941.GW5219@scorpius.homelinux.org>
References: <4879B0C6C249214CBE7AB04453F84E4D050B55@zch01exm20.fsl.freescale.net>
	<4856A73A-BB23-4850-A697-1CE7C385DE42@kernel.crashing.org>
	<1E6652B1-3126-4B69-BE9D-8DCE8DCACE7C@embeddedalley.com>
	<20060719201941.GW5219@scorpius.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4AC92920-4642-4899-B8CA-8EE5A1CDE0B3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
Date: Wed, 19 Jul 2006 15:55:05 -0500
To: Marc Leeman <marc.leeman@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[snip]

> Having my changes for our boards that are very specific since they are
> connected to FPGAs would IMHO serve little purpose in the Linux  
> kernel:
> there is very limited access to the hardware and it would only  
> serve to
> clutter the kernel with an exponentionally growing number of ports  
> that
> most ppl will never use. I think (even though using ARCH and
> CROSS_COMPILE during compilation limits the audience); the target
> audience between U-Boot and the Linux kernel is slightly different.
>
> Though I do agree that there is a gap: it would be nice to have some
> place to submit the kernel patches; possibly not included in the main
> tree; just to see how other ppl are tackling the same problem and
> avoiding re-doing the same work for the nth time (e.g. writing some
> communciation protocol where there are a number of references of ppl
> haveing done them, but no real code).

This should be the kernel.  The general rule of thumb I've used is if  
its useful to more than one other person its worth trying to get into  
the kernel.  However, I can see if you are doing a one off kernel for  
your embedded product that getting your changes into the kernel  
wouldn't be worth while.  You have to have a desire to interact with  
the community if you want to get your code in.

Personally, I see it useful if for no other reason that someone will  
fixup my board port if/when they change something which will make my  
moving to a newer kernel release that much easier.

- k
