Return-Path: <kenneth@southpole.se>
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id B4C40DDF9C
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 03:52:53 +1100 (EST)
Subject: Re: [RFC][PATCH v5] MPC5121 TLB errata workaround
From: Kenneth Johansson <kenneth@southpole.se>
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200903161652.09747.david.jander@protonic.nl>
References: <200903161652.09747.david.jander@protonic.nl>
Content-Type: text/plain
Date: Mon, 16 Mar 2009 17:34:00 +0100
Message-Id: <1237221240.28786.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	gunnar@genesi-usa.com, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-03-16 at 16:52 +0100, David Jander wrote:
> Complete workaround for DTLB errata in e300c2/c3/c4 processors.
> 
> Due to the bug, the hardware-implemented LRU algorythm always goes to way
> 1 of the TLB. This fix implements the proposed software workaround in
> form of a LRW table for chosing the TLB-way.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: David Jander <david@protonic.nl>

I think we have a winner. with one instruction slot left :)
I tried your V4 and V5 and could not see any difference in speed.


Acked-by: Kenneth Johansson <kenneth@southpole.se>
