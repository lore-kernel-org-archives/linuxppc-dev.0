Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 484FCDDDFF
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 07:03:50 +1100 (EST)
Date: Fri, 16 Nov 2007 14:05:10 -0600
From: Olof Johansson <olof@lixom.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Add SPRN for Embedded registers specified in
	PowerISA 2.04
Message-ID: <20071116200510.GA18481@lixom.net>
References: <Pine.LNX.4.64.0711161358280.24588@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0711161358280.24588@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,


On Fri, Nov 16, 2007 at 01:59:03PM -0600, Kumar Gala wrote:
> +#define SPRN_SPRG8	0x25C	/* Special Purpose Register General 8 */
> +#define SPRN_SPRG9	0x25D	/* Special Purpose Register General 8 */

Cut and paste error in comment :)


-Olof
