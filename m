Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B472F1A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 22:58:08 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 471D914033B
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2016 22:58:07 +1100 (AEDT)
Date: Tue, 1 Mar 2016 12:58:03 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH v2 1/8] powerpc: Create a helper for getting the kernel
 toc value
Message-ID: <20160301115803.GA10342@lst.de>
References: <1456737989-8755-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456737989-8755-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 29, 2016 at 08:26:22PM +1100, Michael Ellerman wrote:
> Move the logic to work out the kernel toc pointer into a header. This is
> a good cleanup, and also means we can use it elsewhere in future.

Yes, looks better, very nice.

> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Torsten Duwe <duwe@suse.de>
