Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8ADE2DDF93
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 02:59:03 +1100 (EST)
Date: Fri, 25 Jan 2008 09:56:30 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv3 7/7] [POWERPC] Move definition of buffer descriptor to
	cpm.h
In-Reply-To: <4798ACA5.5050106@scram.de>
Message-ID: <Pine.LNX.4.64.0801250956180.16736@blarg.am.freescale.net>
References: <4798ACA5.5050106@scram.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jan 2008, Jochen Friedrich wrote:

> Buffer descriptors are used by both CPM1 and CPM2. Move the definitions
> from the cpm dependent include file to common cpm.h
>
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
> include/asm-powerpc/cpm.h  |   73 ++++++++++++++++++++++++++++++++++++++++++++
> include/asm-powerpc/cpm1.h |   65 ---------------------------------------
> include/asm-powerpc/cpm2.h |   64 --------------------------------------
> 3 files changed, 73 insertions(+), 129 deletions(-)
>

applied.

- k
