Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9996DDEC1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 08:31:42 +1000 (EST)
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: [U-Boot-Users] [PATCH: dtc take 2] Assemble the blob in memory
	before writing it out.
In-Reply-To: Your message of "Thu, 19 Apr 2007 14:49:43 EDT."
	<4627B9C7.8010800@smiths-aerospace.com>
References: <20070419015951.GA9339@dellserver.lan>
	<1177007241.14328.21.camel@ld0161-tx32>
	<4627B9C7.8010800@smiths-aerospace.com>
Date: Thu, 19 Apr 2007 17:31:36 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HefA8-0008Tl-VA@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	u-boot-users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Jerry Van Baren mumbled:
> 
> Patch #2 and #3...
>    [PATCH dtc take 3] Fix reserve map output for asm format.
>    Tue, 17 Apr 2007 18:14:41 -0400
>    [PATCH: dtc take 2] Assemble the blob in memory before writing it out.
>    Wed, 18 Apr 2007 21:59:51 -0400

[snip]

> AAAARGH!  Sorry, I see I left a debug statement in flattree.c around 
> line 390:

> Your option:
> 1) Take the last two patches as is and remove the fprintf yourself


Applied #2 and #3 listed above.
Cleaned out the debug fprintf().

Thanks,
jdl
