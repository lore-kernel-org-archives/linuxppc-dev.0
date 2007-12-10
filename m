Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9D454DDE32
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 10:02:07 +1100 (EST)
Date: Mon, 10 Dec 2007 17:07:04 -0600
From: Olof Johansson <olof@lixom.net>
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC (Take 2)
Message-ID: <20071210230704.GA2550@lixom.net>
References: <20071207223714.11448.91386.sendpatchset@balbir-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071207223714.11448.91386.sendpatchset@balbir-laptop>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 08, 2007 at 04:07:14AM +0530, Balbir Singh wrote:

> Signed-off-by: Balbir Singh <balbir@linux.vnet.ibm.com>

Looks good to me. Sure, it could be fleshed out to something more
generic and in common code, but this is small and simple and doesn't
bloat the kernel much as it stands, and it has value for debugging.

Acked-by: Olof Johansson <olof@lixom.net>
