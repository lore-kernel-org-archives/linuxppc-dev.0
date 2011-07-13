Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (unknown [IPv6:2406:a000:f000:9500::1])
	by ozlabs.org (Postfix) with ESMTP id 93BD31007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jul 2011 12:41:27 +1000 (EST)
Date: Wed, 13 Jul 2011 11:41:14 +0900
From: Simon Horman <horms@verge.net.au>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: Re: [PATCH] [v3] kexec-tools: ppc32: Fixup ThreadPointer for
	purgatory code
Message-ID: <20110713024113.GA6598@verge.net.au>
References: <20110712095029.18466.30735.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110712095029.18466.30735.stgit@suzukikp.in.ibm.com>
Cc: kexec <kexec@lists.infradead.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 12, 2011 at 03:20:40PM +0530, Suzuki K. Poulose wrote:
> PPC32 ELF ABI expects r2 to be loaded with Thread Pointer, which is 0x7000
> bytes past the end of TCB. Though the purgatory is single threaded, it uses
> TCB scratch space in vsnprintf(). This patch allocates a 1024byte TCB
> and populates the TP with the address accordingly.
> 
> Changes from V2: Avoid address overflow in TP allocation.
> Changes from V1: Fixed the addr calculation for uImage support.
> 
> 
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> Cc: Ryan S. Arnold <rsa@us.ibm.com>

Thanks, applied.
