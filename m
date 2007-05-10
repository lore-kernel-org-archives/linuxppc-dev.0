Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B112DDDF5
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 15:40:59 +1000 (EST)
Subject: Re: [PATCH] Generalize hpte_decode()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17986.44428.934539.499645@cargo.ozlabs.ibm.com>
References: <17986.44428.934539.499645@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 10 May 2007 15:40:53 +1000
Message-Id: <1178775653.14928.208.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-10 at 15:28 +1000, Paul Mackerras wrote:
> This adds the necessary support to hpte_decode() to handle 1TB
> segments and 16GB pages, and also removes an uninitialized value
> warning on avpn.
> 
> We don't have any code to generate HPTEs for 1TB segments or 16GB
> pages yet, so this is mostly for completeness, and also to fix the
> warning.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Not that you really need it but ...

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
