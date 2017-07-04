Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x212B2hJvzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 20:48:34 +1000 (AEST)
In-Reply-To: <1498136847-10709-1-git-send-email-clombard@linux.vnet.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [V4] cxl: Export library to support IBM XSL
Message-Id: <3x212B1xVNz9s9Y@ozlabs.org>
Date: Tue,  4 Jul 2017 20:48:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-22 at 13:07:27 UTC, Christophe Lombard wrote:
> This patch exports a in-kernel 'library' API which can be called by
> other drivers to help interacting with an IBM XSL on a POWER9 system.
> 
> The XSL (Translation Service Layer) is a stripped down version of the
> PSL (Power Service Layer) used in some cards such as the Mellanox CX5.
> Like the PSL, it implements the CAIA architecture, but has a number
> of differences, mostly in it's implementation dependent registers.
> 
> The XSL also uses a special DMA cxl mode, which uses a slightly
> different init sequence for the CAPP and PHB.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3ced8d73006321bd2a0412fa0ff4b0

cheers
