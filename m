Return-Path: <horms@tabatha.lab.ultramonkey.org>
Received: from mail.valinux.co.jp (fms-01.valinux.co.jp [210.128.90.1])
	by ozlabs.org (Postfix) with ESMTP id CA3C7DDF56
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 16:14:20 +1000 (EST)
Date: Tue, 1 May 2007 14:54:24 +0900
From: Simon Horman <horms@verge.net.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] kexec ppc64: cleanup get_devtree_details
Message-ID: <20070501055422.GA20102@verge.net.au>
References: <10869.1177991234@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10869.1177991234@neuling.org>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 01, 2007 at 01:47:14PM +1000, Michael Neuling wrote:
> Cleanup error paths in get_devtree_details.  Also convert fstat from a
> pointer to avoid malloc.

Thanks, applied.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/
