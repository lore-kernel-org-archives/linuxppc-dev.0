Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id DF7CA679F0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 01:37:45 +1000 (EST)
From: Jon Loeliger <jdl@freescale.com>
To: Jakob Viketoft <jakob.viketoft@bitsim.se>
In-Reply-To: <428C352E.1050002@bitsim.se>
References: <428C352E.1050002@bitsim.se>
Content-Type: text/plain
Message-Id: <1116517058.24754.10.camel@gleep>
Mime-Version: 1.0
Date: Thu, 19 May 2005 10:37:38 -0500
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

So, there were two positive comments that I received
as feedback on my initial suggestion, and no negative
comments.  (Minor patch deltas not withstanding.)

I am _almost_ actively back to working on this issue.

Right now, I am in the process of re-grabbing a new
tree from GIT-land and reconstructing my tree and patch
based on current top-of-GIT.

My desire will then be to re-submit the patch for real
and have it applied to the tree in an effort to isolate
the __res and friends to one localized area with a
well-defined interface.

I will then read Ben's proposal in detail and move
forward from there.

HTH!
jdl
