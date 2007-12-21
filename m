Return-Path: <lists@nerdbynature.de>
Received: from mail.g-house.de (ns2.g-housing.de [81.169.133.75])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1B7FDDDED
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 10:34:45 +1100 (EST)
Date: Sat, 22 Dec 2007 00:34:25 +0100 (CET)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Oops: Kernel access of bad area
In-Reply-To: <20071220214705.GA28696@localdomain>
Message-ID: <alpine.DEB.0.99999.0712220026200.6696@sheep.housecafe.de>
References: <alpine.DEB.0.99999.0712192301220.6696@sheep.housecafe.de>
	<20071220214705.GA28696@localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Cc: Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Dec 2007, Nathan Lynch wrote:
> Better to include the full stack trace in such reports,

Hm, I did not want to clutter the mail with all this stuff, but you're 
right, in this case it would've made sense...

> So it looks like the kernel oopsed while firefox was dumping core,
> yuck. It's a real bug.  Hopefully someone on the list can help...

As it's the first time this happened and I could not reproduce it so far 
(the only thing I can reproduce is the ffox crash :)), I doubt it'll be 
"fixable" somehow...

Thanks,
Christian.
-- 
BOFH excuse #247:

Due to Federal Budget problems we have been forced to cut back on the number of users able to access the system at one time. (namely none allowed....)
