Return-Path: <hare@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3800D1A0A15
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 02:35:35 +1100 (AEDT)
Message-ID: <564DEC41.5010600@suse.de>
Date: Thu, 19 Nov 2015 16:35:29 +0100
From: Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>
CC: Mark Salter <msalter@redhat.com>,
 "James E. J. Bottomley" <JBottomley@odin.com>,
 brking <brking@us.ibm.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-block@vger.kernel.org
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:1096!
References: <1447838334.1564.2.camel@ellerman.id.au>
 <1447855399.3974.24.camel@redhat.com>
 <1447894964.15206.0.camel@ellerman.id.au>
 <20151119082325.GA11419@infradead.org>
In-Reply-To: <20151119082325.GA11419@infradead.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/19/2015 09:23 AM, Christoph Hellwig wrote:
> It's pretty much guaranteed a block layer bug, most likely in the
> merge bios to request infrastucture where we don't obey the merging
> limits properly.
> 
> Does either of you have a known good and first known bad kernel?

Well, I have been fighting a similar issue for several months now,
albeit with multipath enabled. Haven't had much progress with this,
sadly.
Seeing that this is our distro kernel it might or might not be
related; however, as the symptoms are identical there still is a
chance that this is actually a generic block-layer problem.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
