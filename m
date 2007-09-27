Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id F0FB3DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 04:48:05 +1000 (EST)
Date: Thu, 27 Sep 2007 13:51:21 -0500
From: Olof Johansson <olof@lixom.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v4] Make instruction dumping work in real mode.
Message-ID: <20070927185121.GA7258@lixom.net>
References: <20070927183855.GA18226@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070927183855.GA18226@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2007 at 01:38:55PM -0500, Scott Wood wrote:
> On non-book-E-or-4xx, exceptions execute in real mode.  If a fault happens
> that leads to a register dump, the kernel currently prints XXXXXXXX because
> it doesn't realize that PC is a physical address.
> 
> This patch checks the state of the IMMU, and if necessary converts PC into a
> virtual address.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
