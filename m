Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 69D8DDDE27
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 02:54:06 +1000 (EST)
Message-ID: <47221BB4.5000303@ru.mvista.com>
Date: Fri, 26 Oct 2007 20:54:12 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 2/2] PowerPC: NDFC entry for PowerPC 440EPx Sequoia DTS
References: <20071026164130.GA11812@ru.mvista.com>
In-Reply-To: <20071026164130.GA11812@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, sr@denx.de,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Valentine Barshak wrote:

> NDFC (NAND Flash Controller) DTS entry for PowerPC 440EPx Sequoia board.
> The NDFC is relocatable in EBC space.

> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

    You need to documents the layout in  the 
Documentation/powerpc/booting-without-of.txt file

WBR, Sergei
