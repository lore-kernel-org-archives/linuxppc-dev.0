Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDD2F1A2AAD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 06:36:20 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Generic IOMMU pooled allocator
Date: Sun, 22 Mar 2015 20:36:02 +0100
References: <20150318.222517.1444725543017433108.davem@davemloft.net>
In-Reply-To: <20150318.222517.1444725543017433108.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201503222036.02669.arnd@arndb.de>
Cc: sparclinux@vger.kernel.org, sowmini.varadhan@oracle.com, paulus@samba.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 19 March 2015, David Miller wrote:
> PowerPC folks, we're trying to kill the locking contention in our
> IOMMU allocators and noticed that you guys have a nice solution to
> this in your IOMMU code.
> 
> Sowmini put together a patch series that tries to extract out the
> generic parts of your code and place it in lib/iommu-common.c so
> that both Sparc and PowerPC can make use of it.
> 
> The real test is if powerpc can be converted to use it.
> 
> So if you guys could please take a look at the current version of
> this series at:
> 
> http://patchwork.ozlabs.org/patch/449712/
> http://patchwork.ozlabs.org/patch/449713/
> http://patchwork.ozlabs.org/patch/449715/
> 
> and give us some feedback that would be great.
> 
> After we sort out making this work properly for both architectures we
> can figure out who merges which parts via what tree(s)

How does this relate to the ARM implementation? There is currently
an effort going on to make that one shared with ARM64 and possibly
x86. Has anyone looked at both the PowerPC and ARM ways of doing the
allocation to see if we could pick one of the two to work on
all architectures?

	Arnd
