Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B9F5D67C75
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 00:52:49 +1000 (EST)
Date: Wed, 23 Aug 2006 09:51:38 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Subject: Re: BogoMIPS no longer supported on PowerPC?
Message-ID: <20060823145138.GH614@pb15.lixom.net>
References: <1156329453.3914.13.camel@ux156>
	<4879B0C6C249214CBE7AB04453F84E4D0FC20C@zch01exm20.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0FC20C@zch01exm20.fsl.freescale.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 23, 2006 at 06:55:26PM +0800, Li Yang-r58472 wrote:
> Ok, I rephrase my question as is it no longer needed?  Sometimes people
> may use this value as a rough estimation of CPU performance.  There are
> people even maintained a list of bogoMIPS of most CPUs.  Maybe it is
> still needed for some legacy reasons.  I'm not very sure.  :)   At leave
> we need to inform people who do look at this magic number and find it
> amazingly low.

Bogomips has never had anything to do with performance on PPC, it's just
a number that's based on the decrementer frequency. For processors with
external/fixed decrementer clock, it will not vary between different
processors in a meaningful way.

Every now and then someone will ask "why does my PPC box have such low
bogomips, is it really that much slower than my PC?". Removing all output
would certainly help avoid that confusion.

For reference, my G5 here has 66.56 bogomips, which corresponds well to
the 33MHz decrementer clock it uses.


-Olof
