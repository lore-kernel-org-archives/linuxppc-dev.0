Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 3CDFA687DE
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2005 08:58:55 +1100 (EST)
Date: Thu, 1 Dec 2005 14:58:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Message-ID: <20051201215852.GH3757@smtp.west.cox.net>
References: <20051117210902.GB31775@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051117210902.GB31775@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc boot: replace string labels with numbers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2005 at 10:09:02PM +0100, Olaf Hering wrote:

> Replacing the string labels with numbers saves 117 bytes in the final zImage.
> These local labels are not discared.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>

And kicks easy-understanding right in the, somethings...

NAK.  If it's not too late, of course (vacation catchup is fun!)

-- 
Tom Rini
http://gate.crashing.org/~trini/
