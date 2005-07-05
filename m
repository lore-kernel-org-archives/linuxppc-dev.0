Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 7E91267C7E
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jul 2005 05:58:20 +1000 (EST)
Date: Tue, 5 Jul 2005 12:58:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Message-ID: <20050705195819.GD6878@smtp.west.cox.net>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<20050703172955.GA25976@suse.de>
	<20050703183237.GC16764@smtp.west.cox.net>
	<20050705181448.GA28142@suse.de>
	<20050705194724.GB6878@smtp.west.cox.net>
	<20050705195441.GA15455@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050705195441.GA15455@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 05, 2005 at 09:54:41PM +0200, Olaf Hering wrote:
>  On Tue, Jul 05, Tom Rini wrote:
> 
> > gcc info page says that -mcpu=powerpc won't work for 601.
> 
> -mcpu=common may work for everyone, after a quick grep in
> gcc/config/rs6000

It does, and that's the code bloat you're trying to get rid of :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
