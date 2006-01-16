Return-Path: <dhlii@dlasys.net>
Received: from xm.dlasys.net (unknown [24.152.213.223])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 08DBB68A25
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Jan 2006 16:31:06 +1100 (EST)
Received: from [206.223.20.50] (port=49187)
	by xm.dlasys.net with esmtp (Exim 4.60 #1 (Debian))
	id 1Eyj2L-0002iM-QJ
	for <linuxppc-embedded@ozlabs.org>; Tue, 17 Jan 2006 00:05:41 -0500
Message-ID: <43CB2EAB.7080307@dlasys.net>
Date: Mon, 16 Jan 2006 00:27:07 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 00/10] Xilinx Virtex-* updates
References: <11367955793438-git-send-email-grant.likely@secretlab.ca>
	<87u0c8q9f4.fsf@48ers.dk>
In-Reply-To: <87u0c8q9f4.fsf@48ers.dk>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I merged your ml403 changes into my copy of the kernel.org linux-2.6 git
 repository, and I am working to adapt my Pico E12-Virtex-4 port to work
with them. I have mostly succeeded, but I am still working through a few
rough spots.

Peter Korsgaard wrote:
>>>>>>"grant" == grant likely <grant.likely@secretlab.ca> writes:
> 
> 
>  grant> Here's a repost of my Xilinx ML300 and ML403 patches with a few
>  grant> cleanups, a bit of patch reordering, and rebased to 2.6.15.
> 
> Nice, ..
> 
>  grant> I've tested on an ML403
>  grant> Can someone test on an ML300?  (I no longer have one)
> 
> Works fine here on a ML300-alike board.
> 
