Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJ3Pp0wW0zDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 05:23:09 +1000 (AEST)
Date: Mon, 22 Aug 2016 13:22:56 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] powerpc: Do not make the entire heap executable
Message-ID: <20160822192256.GA10199@obsidianresearch.com>
References: <20160810130030.5268-1-dvlasenk@redhat.com>
 <874m6ejf81.fsf@linux.vnet.ibm.com>
 <47a2e87e-5299-a009-8a65-5171b33967a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47a2e87e-5299-a009-8a65-5171b33967a1@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 22, 2016 at 08:37:05PM +0200, Denys Vlasenko wrote:

> >Is this going to break any application ? I am asking because you
> >mentioned the patch is lightly tested.
> 
> I booted powerpc64 machine with RHEL7 installation,
> it did not catch fire.

When I authored the original patch my concern was if it had unforseen
impacts on other platforms. I know PPC32 and ARM32 work OK.

It would good to test other platforms as well.

Jason
