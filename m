Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id B49A467A64
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Feb 2005 02:20:06 +1100 (EST)
Date: Fri, 11 Feb 2005 08:20:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andre' Draszik <andid@gmx.net>
Message-ID: <20050211152001.GB9443@smtp.west.cox.net>
References: <4206EFDC.3090904@gmx.net>
	<20050208223348.GA31592@smtp.west.cox.net>
	<420C6EC6.4020800@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <420C6EC6.4020800@gmx.net>
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

On Fri, Feb 11, 2005 at 09:37:26AM +0100, Andre' Draszik wrote:
> Tom Rini wrote:
> >On Mon, Feb 07, 2005 at 05:34:36AM +0100, Andre' Draszik wrote:
> >
> >
> >>This one fixes mktree. The image size stored in the header is pretty off 
> >>without
> >>this patch. (yes, it can make a difference of upto almost 64k)
> >>
> >>Signed-off-by: Andre' Draszik <andid@gmx.net>
> >
> >
> >With this wrong, what breaks?  Thanks.
> 
> I don't think anything breaks but if somebody relies on the image size 
> stored in the header, up to almost 64k bytes of flash could be wasted.

OK.  I'll push this up once 2.6.12-rc1 opens up.

-- 
Tom Rini
http://gate.crashing.org/~trini/
