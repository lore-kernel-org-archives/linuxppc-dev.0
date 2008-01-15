Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D901DDECA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 04:02:15 +1100 (EST)
Subject: Re: PPC vs POWERPC
From: Jon Loeliger <jdl@freescale.com>
To: Matias Sundman <linux@sundmangroup.com>
In-Reply-To: <478C8D38.3090602@sundmangroup.com>
References: <23145.147.11.3.128.1200054808.squirrel@www.sundmangroup.com>
	<fa686aa40801110652s67b2a05al79f78144c5b527bd@mail.gmail.com>
	<478C8D38.3090602@sundmangroup.com>
Content-Type: text/plain
Message-Id: <1200416484.14540.5.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 15 Jan 2008 11:01:33 -0600
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2008-01-15 at 04:38, Matias Sundman wrote:
>  >>Documentation/powerpc/booting-without-of.txt to find out what is
>  >>expected in the device tree.
> 
> Is there any more information on how the "of_*" ( e.g. of_node_put ,  
> of_find_node_by_type ) functions should be implemented in  the 
> "arch/powerpc/platforms/myplatform/myboard_setup.c" file
> or is the documentation the existing "*.c" c files under 
> arch/powerpc/platforms ?
> 
> Since I have a 82xx board I assume that "myboard_setup.c" file shall be 
> put under arch/powerpc/platforms/82xx.

Maybe.  Which 82xx is it?  There is a notable difference
between, say, the 824x boards and the 827x boards.  If it
is the latter, perhaps the existing 82xx/ pq2 or mpc8272
parts are already sufficient?

If it is the former group, 824x, perhaps some of the parts
in embedded6xx/ are usable?  Also note that I am working on
publishing an 824x StorCenter port under embedded6xx/ at
this time as well.  First patches were posted to linuxppc-dev
list at ozlabs.org.

HTH,
jdl
