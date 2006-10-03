Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id E7ABA67C3B
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 04:02:50 +1000 (EST)
Date: Tue, 3 Oct 2006 13:02:45 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/7] Add MPC8360EMDS board support
Message-Id: <20061003130245.58267c54.kim.phillips@freescale.com>
In-Reply-To: <41AC40EF-31AC-42FE-9C1A-9B80233D2E64@kernel.crashing.org>
References: <20061002200946.1f411bcc.kim.phillips@freescale.com>
	<41AC40EF-31AC-42FE-9C1A-9B80233D2E64@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2 Oct 2006 22:19:14 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> [snip]
> 

> > +static u8 *bcsr_regs = NULL;
> > +
> > +u8 *get_bcsr(void)
> > +{
> > +	return bcsr_regs;
> > +}
> 
> Is get_bcsr() needed since you removed its use from ucc_geth?  (if  
> not, let's remove it and the header as well).
> 

it will be once we figure out a better way of handling it from usb and ethernet phy code. I had just removed it due to Paul's comment (bcsr bits are being manipulated in the wrong place (ucc_geth)).

Kim
