Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3mCJ5MnwzDqQn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 05:16:28 +1000 (AEST)
Date: Tue, 2 Aug 2016 12:41:13 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Do not make the entire heap executable
Message-ID: <20160802184113.GA19055@obsidianresearch.com>
References: <20160801210721.27718-1-dvlasenk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160801210721.27718-1-dvlasenk@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 01, 2016 at 11:07:21PM +0200, Denys Vlasenko wrote:
> On 32-bit powerps the ELF PLT sections of binaries (built with --bss-plt,
> or with a toolchain which defaults to it) look like this:

Hi Denys,

Thanks for resurrecting this, I am still interested here, we have been
using this patch in our PPC & ARM32 systems since it was posted.

Benjamin gave some feedback that some small style issues might need
changing, but I never agitated enough to get feedback from mm or core,
which is really what is needed for this patch..

Jason
