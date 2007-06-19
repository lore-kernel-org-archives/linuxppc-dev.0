Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18039.28134.815870.722438@cargo.ozlabs.ibm.com>
Date: Tue, 19 Jun 2007 15:47:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: olof@lixom.net (Olof Johansson)
Subject: Re: for-2.6.23 branch in powerpc.git created
In-Reply-To: <20070615135349.GA28486@lixom.net>
References: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
	<20070615135349.GA28486@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> The following two were postponed to 2.6.23 (CF driver and IDE glue):
> 
> http://patchwork.ozlabs.org/linuxppc/patch?id=11094
> http://patchwork.ozlabs.org/linuxppc/patch?id=11148
> 
> These two are marked "awaiting upstream" but never showed up:
> 
> http://patchwork.ozlabs.org/linuxppc/patch?id=11147
> http://patchwork.ozlabs.org/linuxppc/patch?id=11452

It looks to me like 11148 (Electra CF driver) and 11147 (pcmcia: ppc64
needs 32-bit ioaddr_t) need to go to the pcmcia maintainer.  You can
put Acked-by: Paul Mackerras <paulus@samba.org> on them.

I'll put the other two in.

Paul.
