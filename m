Return-Path: <tnt@246tNt.com>
Received: from outmx028.isp.belgacom.be (outmx028.isp.belgacom.be
	[195.238.5.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F10267BAD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 06:31:09 +1100 (EST)
Received: from outmx028.isp.belgacom.be (localhost [127.0.0.1])
	by outmx028.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBCJUhrF032689
	for <linuxppc-embedded@ozlabs.org>; Tue, 12 Dec 2006 20:30:44 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <457F0322.3020807@246tNt.com>
Date: Tue, 12 Dec 2006 20:29:38 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Andrea Galbusera <andrea.galbusera@teamware.it>
Subject: Re: Which kernel for Lite5200 based target board?
References: <1165936728.32602.59.camel@localhost.localdomain>
In-Reply-To: <1165936728.32602.59.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> I know Sylvain Munaut is/was also maintaining a kernel tree with working
> support for IDE and Bestcomm. This tree seems not very active to me but
> my git wisdom is very very poor and I may be wrong :-(
>   
The recent work in my git tree didn't take place in the 'master' branch
so you don't
see it at first ;)

> Please, consider this as a preliminary post. I'm looking for general
> suggestion on the more convenient kernel to stay with. I know I will
> still need some patching to make everything work fine, but I can't spend
> too much time on "unpromising" solutions. If useful I can then post
> details about the specific problems I have with IDE and ethernet in
> particular.
>   
My 2cents :
 - Update to a real recent u-boot, with device tree support for the 5200.
 - Write a device tree for you board based on the lite5200.dts and
lite5200b.dts in
the kernel source.
 - This day, use gcl tree. What tree to use between gcl and mine to have
the latest
can vary from day to day depending on what we do ... but we shouldn't lag
too much behind.

And use the arch=powerpc support. That's where we're both (Grant and I)
working so ...

The 2.6.20 should have support for quite a bit out of the box. The most
notable exception being no bestcomm (so no ethernet and ATA is PIO only).
This will come later (hopefully 2.6.21 ;)
But by using our development tree (Grant and mine), you will have more
functionnality, at the price that once in a while ... it may not
compile/boot ;)

> Can you tell me where to find details about the status of the Lite520
> support in the kernels listed above? Or maybe suggest me another kernel
> to go with?
>   
It should be there www.246tNt.com/mpc52xx/ ... but I haven't written it
yet ;)


    Sylvain
