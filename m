Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF60DDDEDA
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 23:44:31 +1100 (EST)
Message-Id: <9AE5B028-CEB5-456A-B97F-834D0A9B665A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1221866428-20621-1-git-send-email-ncase@xes-inc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v2] edac: mpc85xx: Add support for MPC8572
Date: Tue, 7 Oct 2008 07:39:17 -0500
References: <1221866428-20621-1-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Kilkenny <akilkenny@xes-inc.com>,
	Dave Jiang <djiang@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 19, 2008, at 6:20 PM, Nate Case wrote:

> From: Andrew Kilkenny <akilkenny@xes-inc.com>
>
> This adds support for the dual-core MPC8572 processor.  We have
> to support making SPR changes on each core.  Also, since we can
> have multiple memory controllers sharing an interrupt, flag the
> interrupts with IRQF_SHARED.
>
> Signed-off-by: Andrew Kilkenny <akilkenny@xes-inc.com>
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> ---
> drivers/edac/mpc85xx_edac.c |   28 +++++++++++++++++++++++-----
> 1 files changed, 23 insertions(+), 5 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

Guys, is there an edac git tree or something to create patches  
against?  I've got one I've been sitting on but it should be updated  
based on Nate's patch.

- k
