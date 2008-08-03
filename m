Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ECA86DDECA
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Aug 2008 00:58:34 +1000 (EST)
Message-Id: <A5259752-468C-4CBA-BEF3-4E088ED1A5B9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20080801152030.ff10b6b2.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] powerpc: move include files to arch/powerpc/include/asm
Date: Sun, 3 Aug 2008 09:58:14 -0500
References: <20080801152030.ff10b6b2.sfr@canb.auug.org.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Roland Dreier <rdreier@cisco.com>,
	LKML <linux-kernel@vger.kernel.org>,
	general@lists.openfabrics.org, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 1, 2008, at 12:20 AM, Stephen Rothwell wrote:

> from include/asm-powerpc.  This is the result of a
>
> mkdir arch/powerpc/include/asm
> git mv include/asm-powerpc/* arch/powerpc/include/asm
>
> Followed by a few documentation/comment fixups and a couple of places
> where <asm-powepc/...> was being used explicitly.  Of the latter only
> one was outside the arch code and it is a driver only built for  
> powerpc.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>
> v2 don't change other arch files - the fixups are only in comments  
> anyway.
>
> This patch can be applied with "git am" - the full patch is way to bug
> for our mailing lists.
>
> This has been built for all the powerpc defconfigs including
> all{no,mod,yes}config.  There was only one failure, but that is
> expected anyway (I had to apply patches for the iommu and hfcmulti
> breakages).

Paul, what's the plan for this change?  If this is something that will  
go in so can we get a tree with it so we can base other patches on it  
(like the PPC_MERGE cleanup)?

- k
