Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 429342BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Oct 2004 05:18:33 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0410051228520.5107@dell.enoriver.com>
References: <Pine.LNX.4.60.0410051228520.5107@dell.enoriver.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A337CA12-1703-11D9-B4FB-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 5 Oct 2004 15:20:37 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] first in a series to enhance microcode patches
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 5, 2004, at 12:32 PM, Robert P. J. Day wrote:

>   (after a short discussion with tom rini, we're going to ignore any 
> previous patch submissions of mine WRT microcode patches and start 
> fresh.  first trivial patch, just to start things off.)

No, send a whole patch that _does_ something.  Let's see all of these
changes at once.  By itself, this patch is useless and doesn't add any
features, it just wastes our time discussing it.

>   2) redeclares reserved chunks in structures to be in terms of a
>      standard char array, rather than the hideous combination of uint,
>      ushort, and so on.  (a purely aesthetic fix, admittedly.)

Just for information, most of the original data structures were all
machine generated with some minor manual touch ups.  I certainly
wasn't going to type in all of that stuff and risk mistakes with offsets
and sizes.

Thanks.

	-- Dan
