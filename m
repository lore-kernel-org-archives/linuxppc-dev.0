Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0AA86DDE26
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 03:01:25 +1000 (EST)
Date: Mon, 28 May 2007 12:06:25 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] pasemi idle uses hard_smp_processor_id
Message-ID: <20070528170625.GA21339@lixom.net>
References: <20070528102045.5fb60480.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070528102045.5fb60480.sfr@canb.auug.org.au>
From: olof@lixom.net (Olof Johansson)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 28, 2007 at 10:20:45AM +1000, Stephen Rothwell wrote:
> and so needs to include asm/smp.h so a UP build works.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks Stephen!

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
