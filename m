Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ADF8ADDDFE
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 02:27:36 +1000 (EST)
In-Reply-To: <1182356216.5674.370.camel@rhino>
References: <1182298509.5674.356.camel@rhino>
	<567a30ea184b6efc37e4c5df60fea1ac@kernel.crashing.org>
	<46795026.8040502@ru.mvista.com>
	<000737fbc16c8d25bb3ebcdc9bbd9eab@kernel.crashing.org>
	<1182356216.5674.370.camel@rhino>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ed05d9e1600e49a37b9038eaa404527e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix I8042 IRQs on MPC8641 HPCN
Date: Wed, 20 Jun 2007 18:27:22 +0200
To: Wade Farnsworth <wfarnsworth@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Uh yeah, bit 1, it's hard to count these single-byte quantities :-)
>
> Yep, only IRQ's 1 and 12 should be changed here.
>
>>>>  If not, you need to change the comment too.
>
> I'm not the original author of the comment, but I think it's only
> mentioning the IRQ's whose triggering is being modified here.  The
> omitted IRQ's already had the correct triggering.

Yeah.

> In any case, I can clarify the comment to make it more clear.

The commit message already mentioned IRQ 1, all is fine :-)


Segher
