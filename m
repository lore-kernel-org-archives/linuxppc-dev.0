Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 1B319679F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 02:34:14 +1000 (EST)
Date: Wed, 18 May 2005 09:34:10 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050518093410.A17800@cox.net>
References: <55497ec3de50301c9f568be24ed3edac@embeddededge.com>
	<96c735b4d1269864b56c84c72a8a4ac3@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <96c735b4d1269864b56c84c72a8a4ac3@freescale.com>;
	from kumar.gala@freescale.com on Wed, May 18, 2005 at 11:19:15AM
	-0500
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: fix CONFIG_TASK_SIZE handling on 44x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, May 18, 2005 at 11:19:15AM -0500, Kumar Gala wrote:
> While we wait on this I think getting Eugene's patch is worth while.

It's been on my long todo list for awhile anyway. Since I added the
advanced option stuff I've been aware of task size issue on 4xx. It's
already been sent upstream.

-Matt
