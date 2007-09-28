Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 18418DDE02
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 16:54:33 +1000 (EST)
Date: Fri, 28 Sep 2007 15:54:25 +0900 (JST)
Message-Id: <20070928.155425.-1300519326.kouish@swc.toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 4/7] Celleb: New HTAB Guest OS Interface on Beat
In-Reply-To: <1190881866.6158.13.camel@pasglop>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Thu, 2007-09-27 at 16:53 +0900, Ishizaki Kou wrote:
> > This is a patch kit to work with new Guest OS Interface
> > to tweak HTAB on Beat. It detects old and new Guest OS Interfaces
> > automatically.
>
> You may also consider adding an API to Beat to invalidate ranges of
> addresses. We could us that through the batch invalidate mechanism to
> speed up significantly process tear down and forks typically.

Thank you for your suggestion, we'll consider it for next release of
Beat.

Best regards,
Kou Ishizaki
