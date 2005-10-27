Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id 9DC226857D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 07:08:51 +1000 (EST)
To: jeff@theptrgroup.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Oct 2005 10:28:43 EDT."
	<1130423323.8477.24.camel@nighteyes.site>
Date: Thu, 27 Oct 2005 23:08:30 +0200
Sender: wd@denx.de
Message-Id: <20051027210830.6DE57353E3E@atlas.denx.de>
Cc: David Jander <david.jander@protonic.nl>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8xx support in 2.6 and [PATCH] USB host controller
	selection...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1130423323.8477.24.camel@nighteyes.site> you wrote:
>
> > > I just rsynced DENX's git tree (cg-clone will crash on a 404 error).
> > 
> > Make sure to use current versions of git resp. cogito.
> 
> I get the same errors using using the latest versions: git version
> 0.99.8f and cogito-0.15.  FWIW, the u-boot.git came down just fine.
...
> Cannot obtain needed blob ca442d313d86dc67e0a2e5d584b465bd382cbf5c
> while processing commit cb7f6ec5c2d64db78984188461dc29b72e924180.
> cg-fetch: objects fetch failed
> cg-clone: fetch failed

Don't know what that means.  Accessing  the  tree  using  rsync://...
works fine.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
An expert is a person who avoids the small errors while  sweeping  on
to the grand fallacy.
