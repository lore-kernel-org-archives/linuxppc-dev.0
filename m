Return-Path: <andid@gmx.net>
Received: from mncltd.com (p15112080.pureserver.info [217.160.169.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 783B267A46
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Feb 2005 19:37:35 +1100 (EST)
Message-ID: <420C6EC6.4020800@gmx.net>
Date: Fri, 11 Feb 2005 09:37:26 +0100
From: Andre' Draszik <andid@gmx.net>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <4206EFDC.3090904@gmx.net>
	<20050208223348.GA31592@smtp.west.cox.net>
In-Reply-To: <20050208223348.GA31592@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] mktree fix
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tom Rini wrote:
> On Mon, Feb 07, 2005 at 05:34:36AM +0100, Andre' Draszik wrote:
> 
> 
>>This one fixes mktree. The image size stored in the header is pretty off 
>>without
>>this patch. (yes, it can make a difference of upto almost 64k)
>>
>>Signed-off-by: Andre' Draszik <andid@gmx.net>
> 
> 
> With this wrong, what breaks?  Thanks.

I don't think anything breaks but if somebody relies on the image size 
stored in the header, up to almost 64k bytes of flash could be wasted.


a.
