Return-Path: <mmporter@cox.net>
Received: from fed1rmmtai11.cox.net (fed1rmmtai11.cox.net [68.230.241.48])
	by ozlabs.org (Postfix) with ESMTP id B6A8168623
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2005 06:35:10 +1000 (EST)
Date: Thu, 20 Oct 2005 13:21:50 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Madhu Saravana Sibi Govindan <ssshayagriva@gmail.com>
Message-ID: <20051020132150.A29677@cox.net>
References: <513a5e60510201256k64c0e4fan1557c28a0bdf920c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <513a5e60510201256k64c0e4fan1557c28a0bdf920c@mail.gmail.com>;
	from ssshayagriva@gmail.com on Thu, Oct 20, 2005 at 02:56:21PM
	-0500
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PowerPC/Linux device driver question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 20, 2005 at 02:56:21PM -0500, Madhu Saravana Sibi Govindan wrote:
> I'm not sure how to request this range of physical memory from the
> kernel. I thought I could use ioremap to map this range into the
> virtual space, but ioremap takes only an unsigned long as an argument,
> which is only 32 bits on 440GP. I don't think I can represent the range of my
> device with 32 bits.
> 
> Could someone tell me how to solve the problem? I want this range of
> physical addresses to be associated with my device driver and how do I
> do that?

Use the ppc-specific ioremap64() call. 

-Matt
