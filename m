Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ECA90DDF32
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 01:26:51 +1000 (EST)
Message-Id: <F62A680D-C2D8-42B0-B4D6-F3A00F228EB1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080502150753.GA7753@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions and
	-Os
Date: Fri, 2 May 2008 10:26:43 -0500
References: <Pine.LNX.4.64.0805020920120.1141@blarg.am.freescale.net>
	<20080502150753.GA7753@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2008, at 10:07 AM, Scott Wood wrote:

> On Fri, May 02, 2008 at 09:21:08AM -0500, Kumar Gala wrote:
>> GCC 4.4.x looks to be adding support for generating out-of-line  
>> register
>> saves/restores based on:
>>
>> http://gcc.gnu.org/ml/gcc-patches/2008-04/msg01678.html
>>
>> This breaks the kernel build as we'd have to link with libgcc to  
>> get the
>> implementation of the register save/restores.
>
> <brokenrecord>
> Why don't we just link with libgcc?
> </brokenrecord>

Its something of a PITA to do that in the kernel at this point since  
we've duplicated libgcc functionality in it.  I'm sure there are some  
historical reasons this wasn't done to start with.

- k
