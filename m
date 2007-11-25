Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19E73DDE0E
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 07:38:58 +1100 (EST)
Date: Sun, 25 Nov 2007 23:34:41 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH resend 1/4] powerpc: fix typo #ifdef -> #ifndef
Message-ID: <20071125233441.59cbc44c@kernel.crashing.org>
In-Reply-To: <4745B41B.3040904@scram.de>
References: <4745B41B.3040904@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 22 Nov 2007 17:53:47 +0100
Jochen Friedrich wrote:

> fpi->cp_command should be overwritten only if
> CONFIG_PPC_CPM_NEW_BINDING is NOT set. Otherwise it is already set
> from the device tree.
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Applied to linux-2.6-8xx.git,  for-paulus branch.


-- 
Sincerely, Vitaly
