Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id 15D42DDF23
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 17:11:26 +1100 (EST)
Date: Wed, 8 Oct 2008 17:11:25 +1100
From: Simon Horman <horms@verge.net.au>
To: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [PATCH] Relocatable kdump kernel support in kexec-tools
Message-ID: <20081008061123.GE22396@verge.net.au>
References: <20080930125621.GC1945@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080930125621.GC1945@in.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 30, 2008 at 06:26:21PM +0530, Mohan Kumar M wrote:
> Relocatable kdump kernel support in kexec-tools
> 
> This patch adds relocatable kernel support for kdump in the kexec-tools
> code. A signature (0xfeed1234) is passed in r6 from panic code to the
> purgatory code through kexec_sequence function. The signature is used to
> differentiate between relocatable kdump kernel and non-kdump kernels.
> 
> The purgatory code compares the signature and sets the __kdump_flag in
> head_64.S by using the offset with respect to next kernel load address.
> During the boot up, kernel code checks __kdump_flag and if it is set, the
> kernel will behave as relocatable kdump kernel.

Thanks Mohan, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en
