Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23A8768638
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 23:54:59 +1000 (EST)
In-Reply-To: <8E342283C2100540AAC5D103097054778A4189@rcexc.racoms.loc>
References: <8E342283C2100540AAC5D103097054778A4189@rcexc.racoms.loc>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e08bcb4de7fa6a71f103ce2c50c067f8@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 21 Oct 2005 10:00:42 -0400
To: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8xx soft-float userspace ...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 21, 2005, at 5:31 AM, Schaefer-Hutter, Peter wrote:

> Due to the fact that the in-kernel FPU emulation looks
> broken on MPC8xx i want to build a complete soft-float
> userspace.

How does it "look broken?"  It's always worked for me :-)

> ....  Does anybody have some pointers what else
> needs to be removed?

Well, if you found it, you should be able to trace this to a
source file and remove it, right?

Thanks.

	-- Dan
