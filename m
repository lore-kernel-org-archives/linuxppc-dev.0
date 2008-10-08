Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82AD9DE93D
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 07:42:00 +1100 (EST)
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>
References: <1223495845-14149-1-git-send-email-timur@freescale.com>
	<1223496186.8157.82.camel@pasglop>
	<ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 09 Oct 2008 07:39:40 +1100
Message-Id: <1223498380.8157.86.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-08 at 15:14 -0500, Timur Tabi wrote:
> 
> But this is the reason I sent you the patch in the first place.  I
> think "default y" is wrong and doesn't make any sense, so I'm asking
> you for a technical reason why PMAC and CHRP should default to yes.
> That is the focus of my patch.  The defconfig changes are just to
> clean up the mess that "default y" left behind.

I'm happy with -all- platforms for a given CPU type defaulting to y. 

Ben.
