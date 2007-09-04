Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 216C8DDDE7
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 03:38:36 +1000 (EST)
Message-ID: <46DD9879.7040401@genesi-usa.com>
Date: Tue, 04 Sep 2007 18:40:09 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: "atomic" 64-bit math on 32-bit ppc's?
References: <46DD3CE2.4060301@genesi-usa.com> <20070904113937.GA3994@iram.es>
	<46DD500B.4020207@genesi-usa.com> <20070904160206.GA12698@iram.es>
In-Reply-To: <20070904160206.GA12698@iram.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gabriel Paubert wrote:
> I don't know at all the ZFS code, not any filesystem code for the
> matter. But how many spinlocks would you have to take and release 
> per actual disk operation?

I have no idea, but considering the space supported by the filesystem
it's probably a hell of a lot.

It seems like we've solved it; the Solaris ppc-dev repository has an
updated atomic.c which implements a kernel mutex for 64-bit ops. I've
forwarded this on, hopefully it ISN'T a hell of a lot or this is going
to knock filesystem performance on the head for 32-bit ppc :D

Thanks for your help.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
