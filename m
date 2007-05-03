Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 79AD6DE039
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 03:26:58 +1000 (EST)
Date: Thu, 3 May 2007 12:28:19 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] 86xx: Enable the AC97 interface on 8641D board.
Message-ID: <20070503172819.GA32653@lixom.net>
References: <1178142818.32136.51.camel@ld0161-tx32>
	<08D3A1CE-12E0-4759-B055-DE227EA4135E@kernel.crashing.org>
	<1178207725.17201.33.camel@ld0161-tx32>
	<20070503161000.GA31881@lixom.net>
	<1178209046.17201.55.camel@ld0161-tx32>
	<3C4D879A-E756-45EA-AB67-70902797ED35@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C4D879A-E756-45EA-AB67-70902797ED35@kernel.crashing.org>
From: olof@lixom.net (Olof Johansson)
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 03, 2007 at 11:19:21AM -0500, Kumar Gala wrote:
> 
> On May 3, 2007, at 11:17 AM, Jon Loeliger wrote:
> >>Why not do this in u-boot instead?
> >
> >Why do it there?  We'd have to do it _again_ in Linux
> >if we didn't come in from U-Boot anyway.
> 
> I agree with Jon here.  This is in board specific code so I don't see  
> any issue with it.

Good to know. I'll keep that in mind myself for future reference, no
need to waste effort trying to get clean board ports.


-Olof
