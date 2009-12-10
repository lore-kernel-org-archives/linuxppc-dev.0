Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 635B2B6F0A
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 01:58:11 +1100 (EST)
Date: Thu, 10 Dec 2009 17:58:08 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] cpm2_pic: Allow correct flow_types for port C
	interrupts
Message-ID: <20091210145808.GA16421@oksana.dev.rtsoft.ru>
References: <4B20D81A.7010503@elphinstone.net>
	<9DDC31C7-6AEE-498C-BE18-C286C950BB51@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9DDC31C7-6AEE-498C-BE18-C286C950BB51@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Mark Ware <mware@elphinstone.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 10, 2009 at 08:52:01AM -0600, Kumar Gala wrote:
> 
> On Dec 10, 2009, at 5:14 AM, Mark Ware wrote:
> 
> > Port C interrupts can be either falling edge, or either edge.
> > Other external interrupts are either falling edge or active low.
> > Tested on a custom 8280 based board.
> > 
> > Signed-off-by: Mark Ware <mware@elphinstone.net>
> > ---
> > Changed in v3:
> > - Cosmetic improvements as suggested by Anton and Scott
> > - Added tested note to changelog
> > 
> > arch/powerpc/sysdev/cpm2_pic.c |   28 +++++++++++++++++++++-------
> > 1 files changed, 21 insertions(+), 7 deletions(-)
> 
> Scott, Anton do you want to add an Ack to this version?

Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
