Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (unknown [209.183.211.17])
	by ozlabs.org (Postfix) with ESMTP id 04792685D3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 00:36:06 +1000 (EST)
From: Jeff Angielski <jeff@theptrgroup.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20051027134735.8E7C6353E30@atlas.denx.de>
References: <20051027134735.8E7C6353E30@atlas.denx.de>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 10:28:43 -0400
Message-Id: <1130423323.8477.24.camel@nighteyes.site>
Mime-Version: 1.0
Cc: David Jander <david.jander@protonic.nl>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8xx support in 2.6 and [PATCH] USB host controller
	selection...
Reply-To: jeff@theptrgroup.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-10-27 at 15:47 +0200, Wolfgang Denk wrote:
> In message <200510271439.48990.david.jander@protonic.nl> you wrote:
> > 
> > I am trying to figure out if kernel-2.6.x is already a (stable) option for 
> > MPC8xx processors. Any hints? experience?
> > I just rsynced DENX's git tree (cg-clone will crash on a 404 error).
> 
> Make sure to use current versions of git resp. cogito.

I get the same errors using using the latest versions: git version
0.99.8f and cogito-0.15.  FWIW, the u-boot.git came down just fine.


> cg-clone http://www.denx.de/git/linux-2.6-denx.git linux-2.6-denx
defaulting to local storage area
10:24:51 URL:http://www.denx.de/git/linux-2.6-denx.git/HEAD [41/41] ->
"refs/heads/.origin-fetching" [1]
progress: 1 objects, 264 bytes
walk b2304e619029b177db18dc771f2b9ba8cd273b81
progress: 3 objects, 1180 bytes
walk cb7f6ec5c2d64db78984188461dc29b72e924180
progress: 4 objects, 1424 bytes
error: The requested URL returned error: 404
Getting pack list
error: The requested URL returned error: 404
Getting alternates list
error: Unable to find ca442d313d86dc67e0a2e5d584b465bd382cbf5c under
http://www.denx.de/git/linux-2.6-denx.git/

Cannot obtain needed blob ca442d313d86dc67e0a2e5d584b465bd382cbf5c
while processing commit cb7f6ec5c2d64db78984188461dc29b72e924180.
cg-fetch: objects fetch failed
cg-clone: fetch failed


Jeff Angielski
The PTR Group
