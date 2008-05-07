Return-Path: <sean.maclennan@pikatech.com>
Received: from mail.pikatech.com (dns.pikatech.com [207.107.229.10])
	by ozlabs.org (Postfix) with ESMTP id 118E7DDF08
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 08:03:22 +1000 (EST)
Received: from [207.107.229.5] (helo=pks00005.kanatek.com)
	by mail.pikatech.com with esmtp (Exim 4.51) id 1JtrNj-0003ko-5x
	for linuxppc-dev@ozlabs.org; Wed, 07 May 2008 17:40:59 -0400
Date: Wed, 7 May 2008 17:42:51 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: All your drivers are belong to us [was WARNING: mutexes are
	preferredfor single holder semaphores]
Message-ID: <20080507174251.2af863d6@wally.pikatech.com>
In-Reply-To: <m23aouuqoh.fsf_-_@ohwell.denx.de>
References: <20080504204104.7eea7618@lappy.seanm.ca>
	<1209958719.21644.32.camel@pasglop>
	<20080505004023.05603b93@lappy.seanm.ca>
	<m23aouuqoh.fsf_-_@ohwell.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 07 May 2008 16:36:30 +0200
"Detlev Zundel" <dzu@denx.de> wrote:

> It also happened that a driver once posted for what the customer
> thought was a completely specific device of his own today supports
> lots of different boards from at least four different manufacturers."
> 
> The wording is of course not exact but I hope I caught the spirit of
> what Greg wanted to say.  So yes, please post the driver - maybe Greg
> KH will tunnel it into mainline...

I agree with the sentiment. However, it is hard enough to get
legitimate drivers into the kernel. The drivers I mentioned do not
come close to following the Linux kernel coding spec.

Just to start, they use 2 character spaces for indentation :( They are
full of ifdefs since we need to support the whole gamut of 2.6 kernels
plus windows. We also must support multiple board versions in the same
files.

Cheers,
   Sean
