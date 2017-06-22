Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtfJH71pwzDq8c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 21:20:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH V3] cxl: Export library to support IBM XSL
In-Reply-To: <1498039393-10656-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1498039393-10656-1-git-send-email-clombard@linux.vnet.ibm.com>
Date: Thu, 22 Jun 2017 21:20:15 +1000
Message-ID: <87wp84qnf4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Lombard <clombard@linux.vnet.ibm.com> writes:

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
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

Andrew sent you a SOB for parts he wrote, so you should include that.

Waiting for an ack from Fred before I merge this.

cheers
