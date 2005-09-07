Return-Path: <jangiels@speakeasy.net>
Received: from mail22.sea5.speakeasy.net (mail22.sea5.speakeasy.net
	[69.17.117.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD00968110
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 09:38:47 +1000 (EST)
From: Jeff Angielski <jangiels@speakeasy.net>
To: Frank Beesley <frank.beesley@aeroflex.com>
In-Reply-To: <431F6CDC.7030908@aeroflex.com>
References: <431F6CDC.7030908@aeroflex.com>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 19:29:03 -0400
Message-Id: <1126135743.11227.3.camel@nighteyes.site>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 Linux Init Problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2005-09-07 at 17:42 -0500, Frank Beesley wrote:
> Any clues to help debug this would be greatly appreciated. I have built 
> several different kernel and busybox images with different debug prints 
> to help figure this out and I am at a loss. Please CC me as I am not on 
> the mailing list OR directly email me and we can post the solution back 
> to the list.

Have you compared the stack trace and instruction pointers to the maps
to see which functions are causing the issue?  Are they the same ones?

You are using jffs as your rootfs?  Are you sure the MTD is fully
functional?  Did you port your flash configuration to your kernel
correctly?  Have you tried NFS mounting a rootfs and then playing games
with a jffs filesystem to make sure it is working?

As for things to try, compile Busybox statically and work from there.
Once you get that working, you can play with the dynamic libraries,
making sure the right ones are on your rootfs.


Jeff Angielski
The PTR Group
