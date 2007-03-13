Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id 0FFA0DDE01
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 18:35:16 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
Date: Tue, 13 Mar 2007 08:37:05 +0100
References: <200703122254.27087.sr@denx.de>
	<1173769934.24454.67.camel@localhost.localdomain>
In-Reply-To: <1173769934.24454.67.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703130837.06339.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 13 March 2007 08:12, Benjamin Herrenschmidt wrote:
> While it's a good idea, there are a couple of issues with the patch:
>
>  - It's arch/ppc. We shouldn't do new major features on this codebase.
> You are welcome however in helping moving over 4xx to arch/powerpc :-)

Yes, sure. But the project this patch was developed for started quite a while 
ago when absolutely no 4xx support was available in arch/powerpc. I'm of 
course aware that we have to move to arch/powerpc in the near future and am 
willing to help here.

>  - You only adapted head_4xx.S but the config option is global to all of
> arch/ppc, thus changing it will probably break everything else. Make
> sure the option is done in such a way that it can't be changed or the
> kernel doesn't build if changed for a processor family where you haven't
> implemented the support

OK, will address this problem later.

>  - Have you tried other page sizes ? How hard would it be to support 16K
> and what kind of performance numbers do you get with 16K ? It's a better
> compromise for some applications as 64K causes significant bloat of the
> page cache (among other things).

No, we haven't tested other page sizes. We chose 64K because it is the stripe 
size of the RAID arrays.

Thanks.

Best regards,
Stefan
