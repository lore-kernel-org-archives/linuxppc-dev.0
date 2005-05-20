Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 13D8B679F0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 May 2005 02:40:43 +1000 (EST)
From: Jon Loeliger <jdl@freescale.com>
To: Jakob Viketoft <jakob.viketoft@bitsim.se>
In-Reply-To: <428C352E.1050002@bitsim.se>
References: <428C352E.1050002@bitsim.se>
Content-Type: text/plain
Message-Id: <1116607235.29111.20.camel@gleep>
Mime-Version: 1.0
Date: Fri, 20 May 2005 11:40:36 -0500
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: OF flat device tree for ppc32...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-05-19 at 01:41, Jakob Viketoft wrote:
> Hello Jon!
> 
> Any news on the port of the OF-layer to ppc32? I'd love to hear some 
> more and it would be great be able to help out, even though I have some 
> heavy deadlines hanging over me for the next 2 months. From what I can 
> see on the list, there wasn't many comments on your first preparatory 
> code, but I for one thinks it's time to move it forward anyway.
> 
> What do you say?
> 
> 	/Jakob

Folks,

I have updated my tree and patch to the latest GIT
as of last night.  The new patch is available here:

   http://www.jdl.com/bdt_cleanup_git.patch.gz

Signed-off-by: Jon Loeliger <jdl@freescale.com>

Please let me know if there are difficulties retrieving it.

This patch has a few caveats associated with it.
In particular, it does not address the entire

    arch/ppc/boot/simple

issue at all.  And for that reason, this patch does
not yet actually remove the to-be-obsoleted ppcboot.h
that is otherwise unreferenced.  I am hopeful that
someone who is muchm ore familiar with that code can
pick up from this patch and Do The Right Thing there.

This patch in no-way eliminates the U-Boot-to-Kernel
interface yet.  It merely isolates it all to one location
and provides a functional interface to it.

Enjoy,
jdl
