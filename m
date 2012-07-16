Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 13D622C0110
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 06:36:41 +1000 (EST)
Subject: Re: [PATCH] powerpc: set stack limit properly in
 crit_transfer_to_handler
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342465608-20596-1-git-send-email-stuart.yoder@freescale.com>
Date: Mon, 16 Jul 2012 15:36:25 -0500
Message-Id: <544C2283-0681-496A-B2CE-444505CD17DE@kernel.crashing.org>
References: <1342465608-20596-1-git-send-email-stuart.yoder@freescale.com>
To: Stuart Yoder <stuart.yoder@freescale.com>
Cc: agraf@suse.de, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 16, 2012, at 2:06 PM, Stuart Yoder wrote:

> From: Stuart Yoder <stuart.yoder@freescale.com>
> 
> without setting the stack limit like this there is the possibility
> of stack overflow which corrupts the thread info but
> is not detected by stack overflow detection
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
> arch/powerpc/kernel/entry_32.S |   12 ++++++++++--
> 1 files changed, 10 insertions(+), 2 deletions(-)

Do we need this for debug & mcheck ?

- k
