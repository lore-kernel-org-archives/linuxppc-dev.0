Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 23E4967AB1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Feb 2005 09:33:50 +1100 (EST)
Date: Tue, 8 Feb 2005 15:33:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andre' Draszik <andid@gmx.net>
Message-ID: <20050208223348.GA31592@smtp.west.cox.net>
References: <4206EFDC.3090904@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4206EFDC.3090904@gmx.net>
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

On Mon, Feb 07, 2005 at 05:34:36AM +0100, Andre' Draszik wrote:

> This one fixes mktree. The image size stored in the header is pretty off 
> without
> this patch. (yes, it can make a difference of upto almost 64k)
> 
> Signed-off-by: Andre' Draszik <andid@gmx.net>

With this wrong, what breaks?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
