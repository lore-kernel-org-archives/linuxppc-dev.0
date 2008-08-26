Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6DF14DEE91
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 14:45:04 +1000 (EST)
Subject: Re: Please pull from 'for-2.6.27' (updated)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0808252100440.21525@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0808252100440.21525@blarg.am.freescale.net>
Content-Type: text/plain
Date: Tue, 26 Aug 2008 14:44:53 +1000
Message-Id: <1219725893.13162.127.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-08-25 at 21:09 -0500, Kumar Gala wrote:

> Kumar Gala (3):
>       powerpc: Fix whitespace merge in mpc8641 hpcn device tree
>       powerpc: Update defconfigs for FSL PPC boards
>       powerpc: Fix determining TI_CPU in power_save_ppc32_restore()

Please, don't put a patch in a git pull request that has been out for
review exactly ... 1mn according to the email time stamps.

Cheers,
Ben.
