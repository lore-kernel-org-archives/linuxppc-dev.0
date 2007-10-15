Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64166DDF17
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 04:51:59 +1000 (EST)
Message-ID: <4713B6C4.9090909@pobox.com>
Date: Mon, 15 Oct 2007 14:51:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [PATCH v2] [POWERPC] ucc_geth: Fix build break introduced by
	commit 09f75cd7bf13720738e6a196cc0107ce9a5bd5a0
References: <1192455830-1028-1-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1192455830-1028-1-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, akpm@linux-foundation.org, leoli@Freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Emil Medve wrote:
> drivers/net/ucc_geth.c: In function 'ucc_geth_rx':
> drivers/net/ucc_geth.c:3483: error: 'dev' undeclared (first use in this function)
> drivers/net/ucc_geth.c:3483: error: (Each undeclared identifier is reported only once
> drivers/net/ucc_geth.c:3483: error: for each function it appears in.)
> make[2]: *** [drivers/net/ucc_geth.o] Error 1
> 
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
> 
> Here is a convenient link for the culprit patch: http://git.kernel.org/?p=linux/kernel/git/jgarzik/netdev-2.6.git;a=commit;h=09f75cd7bf13720738e6a196cc0107ce9a5bd5a0
> 
> netdev-2.6> scripts/checkpatch.pl 0001-POWERPC-ucc_geth-Fix-build-break-introduced-by-co.patch 
> Your patch has no obvious style problems and is ready for submission.

applied
