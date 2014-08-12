Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EFC31A0012
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 07:47:17 +1000 (EST)
Date: Tue, 12 Aug 2014 14:47:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 1/2] printk: Add function to return log buffer
 address and size
Message-Id: <20140812144714.d716127f0242417c6172d9f1@linux-foundation.org>
In-Reply-To: <1407719612.4508.52.camel@pasglop>
References: <20140809054424.17676.1090.stgit@hegdevasant.in.ibm.com>
 <1407719612.4508.52.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 11 Aug 2014 11:13:32 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2014-08-09 at 11:15 +0530, Vasant Hegde wrote:
> 
> > Ben,
> >   - This patchset applies cleanly on powerpc next branch.
> >   - Andrew Morton suggested to include this patch in powerpc tree.
> >     (https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/119802.html)
> > 
> 
> Ok, Andrew, can I have an Ack ?

Acked-by: Andrew Morton <akpm@linux-foundation.org>
