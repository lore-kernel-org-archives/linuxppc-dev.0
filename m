Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18419.29305.168659.363143@cargo.ozlabs.ibm.com>
Date: Wed, 2 Apr 2008 22:48:09 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for-2.6.25' branch
In-Reply-To: <D9513606-E9BC-4D20-BB2E-7CCD3D9CEDAA@kernel.crashing.org>
References: <Pine.LNX.4.64.0803311156160.4549@blarg.am.freescale.net>
	<D9513606-E9BC-4D20-BB2E-7CCD3D9CEDAA@kernel.crashing.org>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>, Linus Torvalds <torvalds@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Paul, any comments on sending this onto linus.  I was hoping to avoid  
> 2.6.25 coming up not support the proper device bindings for DMA and  
> SATA.

I've pulled it and I'll send it on later (or Linus can pull it
directly if he wants).  There is the iSeries fix from Ben H plus two
other patches (one from Bartlomiej Sieka and one from Nathan Lynch)
where I'm waiting for proper patch descriptions and/or signed-off-by
lines.  I was hoping to get those tomorrow and send the lot on to
Linus.

Paul.
