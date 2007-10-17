Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6FCE0DDE26
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 16:44:04 +1000 (EST)
Date: Wed, 17 Oct 2007 01:50:15 -0500
From: Olof Johansson <olof@lixom.net>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: 2.6.23-git-10 Build Failure on powerpc - asm-powerpc/dma_mapping.h
Message-ID: <20071017065015.GA21329@lixom.net>
References: <4715A9C1.9090106@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4715A9C1.9090106@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Wed, Oct 17, 2007 at 11:50:49AM +0530, Kamalesh Babulal wrote:

> Build fails on the powerpc fails with 2.6.23-git10

This was fixed by 33ff910f0f466184ffc3514628f18403dcd86761.


-Olof
