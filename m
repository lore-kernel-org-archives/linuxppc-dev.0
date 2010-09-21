Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 42990B70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 07:24:42 +1000 (EST)
Received: by iwn4 with SMTP id 4so2283738iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 14:24:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877FD0B5-19A7-4A16-831E-369B80B104EA@kernel.crashing.org>
References: <1285066638-7473-1-git-send-email-leoli@freescale.com>
	<877FD0B5-19A7-4A16-831E-369B80B104EA@kernel.crashing.org>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Tue, 21 Sep 2010 16:24:10 -0500
Message-ID: <AANLkTimiwtoa6i10OTcgFnvbvcO9N4KWHyt4Poj-yj=T@mail.gmail.com>
Subject: Re: [PATCH] fsldma: add support to 36-bit physical address
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 21, 2010 at 7:55 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Sep 21, 2010, at 5:57 AM, Li Yang wrote:
>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>
> We really should have a sentence about how or why this works to address 36-bit addressing.

For example, I would like to know which memory is going to be
allocated above 4GB.  I don't know much about the kernel's async
library, but my understanding is that fsldma does not allocate any of
the memory buffers that it copies data to/from.  The only memory that
fsldma allocates is for the DMA descriptors, which are very small and
probably don't take up more than a couple pages.

-- 
Timur Tabi
Linux kernel developer at Freescale
