Return-Path: <trini@kernel.crashing.org>
Date: Wed, 6 Apr 2005 16:16:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Message-ID: <20050406231640.GJ3396@smtp.west.cox.net>
References: <20050406223751.E4297C108D@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050406223751.E4297C108D@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Kernel SCM saga..
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 07, 2005 at 12:37:46AM +0200, Wolfgang Denk wrote:

> Hi,
> 
> are there any plans yet how to continue PPC  kernel  development  now
> that Linus (and probably others, too) stopped using BitKeeper?
> 
> See http://www.lib.uaa.alaska.edu/linux-kernel/archive/2005-Week-14/0826.html

Larely unchanged.  The linuxppc-2.5 tree hasn't been active for a while,
so "official" trees shouldn't be a problem.  I would hope/imagine that
whatever is picked up next will allow the sub-projects that've had
multiple colaborators (such as mpc52xx or marvell support) to work in
some fashion.  For single-user stuff, I can't recommend quilt
(http://savannah.nongnu.org/projects/quilt) enough.

-- 
Tom Rini
http://gate.crashing.org/~trini/
