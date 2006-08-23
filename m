Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7570A67C06
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 20:37:14 +1000 (EST)
Subject: Re: BogoMIPS no longer supported on PowerPC?
From: Johannes Berg <johannes@sipsolutions.net>
To: Li Yang-r58472 <LeoLi@freescale.com>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0FC209@zch01exm20.fsl.freescale.net>
References: <4879B0C6C249214CBE7AB04453F84E4D0FC209@zch01exm20.fsl.freescale.net>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 12:37:33 +0200
Message-Id: <1156329453.3914.13.camel@ux156>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-23 at 18:25 +0800, Li Yang-r58472 wrote:
> I noticed a recent modification to __delay has changed from using empty
> loops to reading timebase.  Thus, breaks the calculation of bogomips,
> and makes it terribly low.  Is the bogomips no longer being supported on
> powerpc arch?

What's there to be 'supported'? The only purpose of bogomips is
calibrating the delay loop, and that has changed now by using timebase,
hence bogomips no longer have a purpose. There was even a patch to
remove it from /proc/cpuinfo but I'm not sure whether that got applied
or not.

johannes
