Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 18EACDDED3
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 08:00:00 +1000 (EST)
In-Reply-To: <17961.22721.462194.785356@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0704191615040.25069@localhost.localdomain>
	<17961.22721.462194.785356@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CE31BB28-E702-4425-A266-9D5D143A53DC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Change 440GP platform to ppc440
Date: Mon, 23 Apr 2007 16:58:57 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 20, 2007, at 7:20 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> I don't see any reason the 440GP should its own platform.  Posting  
>> this to
>> see if anyone thinks otherwise.
>
> I recall dimly that there was some user-visible difference between the
> 440GP and the other 440 processors, and that's why we made the
> platform string different.  I don't recall what the difference was.

The 440GP seems to be a book-e userspace w/o FP.  Not sure how it  
differs from other 440's.  It seems like the 440EP are the only ones  
with FPUs.

- k
