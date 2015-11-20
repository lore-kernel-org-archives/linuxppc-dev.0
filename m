Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0D6B1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 23:10:48 +1100 (AEDT)
Message-ID: <1448021448.14769.7.camel@ellerman.id.au>
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:1096!
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mark Salter <msalter@redhat.com>, "James E. J. Bottomley"
 <JBottomley@odin.com>, brking <brking@us.ibm.com>,
 linux-scsi@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,  linux-block@vger.kernel.org, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>
Date: Fri, 20 Nov 2015 23:10:48 +1100
In-Reply-To: <20151119082325.GA11419@infradead.org>
References: <1447838334.1564.2.camel@ellerman.id.au>
 <1447855399.3974.24.camel@redhat.com>
 <1447894964.15206.0.camel@ellerman.id.au>
 <20151119082325.GA11419@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-11-19 at 00:23 -0800, Christoph Hellwig wrote:

> It's pretty much guaranteed a block layer bug, most likely in the
> merge bios to request infrastucture where we don't obey the merging
> limits properly.
> 
> Does either of you have a known good and first known bad kernel?

Not me, I've only hit it one or two times. All I can say is I have hit it in
4.4-rc1.

Laurent, can you narrow it down at all?

cheers
