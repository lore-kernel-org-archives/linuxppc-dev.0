Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id DCDF02BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Nov 2004 03:18:08 +1100 (EST)
Date: Thu, 18 Nov 2004 09:18:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Guillaume Autran <gautran@mrv.com>
Message-ID: <20041118161806.GE12054@smtp.west.cox.net>
References: <419CBB67.1070301@mrv.com>
	<20041118160946.GD12054@smtp.west.cox.net>
	<419CCC85.8080003@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <419CCC85.8080003@mrv.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kernel 2.6.10-rc2 - Embedded MPC8xx - processor option gone !?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Nov 18, 2004 at 11:23:33AM -0500, Guillaume Autran wrote:

> Is anyone working on a fix already ?

Not actively.  The problem has been described on the list a few times
(it seems like there's a stale TLB entry).

> Will the MPC8xx support be functionnal for 2.6.10 ?

Most likely no.

-- 
Tom Rini
http://gate.crashing.org/~trini/
