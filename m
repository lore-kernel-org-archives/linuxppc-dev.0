Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 96BCEDDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 23:06:03 +1000 (EST)
Message-ID: <469384B3.1080502@ru.mvista.com>
Date: Tue, 10 Jul 2007 17:08:03 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ide: Use inline function for eieio
References: <Pine.LNX.4.64.0707100018020.5814@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0707100018020.5814@blarg.am.freescale.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Kumar Gala wrote:
> Move to using inline function variant of eieio instead of inline assmebly.

> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
