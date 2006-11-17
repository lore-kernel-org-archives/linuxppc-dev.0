Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3717767BC4
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 21:18:50 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id kAHAIjIm015142
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 19:18:45 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id kAHAIlD1007324
	for linuxppc-dev@ozlabs.org; Fri, 17 Nov 2006 19:18:47 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id kAHAIj9x015932
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 19:18:45 +0900 (JST)
Date: Fri, 17 Nov 2006 19:18:44 +0900 (JST)
Message-Id: <200611171018.kAHAIjOh014589@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/16] Cell closs-building
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph-san,

> On Wed, Nov 15, 2006 at 06:25:33PM +0900, Ishizaki Kou wrote:
> > This patch adds support for cross-building by SCE toolchain.
> > 
> > Signed-off-by: Kou Ishizaki <kou.ishizaki at toshiba.co.jp>
> > ---
> > 
> > Index: linux-2.6.19/arch/powerpc/Makefile
> > diff -u linux-2.6.19/arch/powerpc/Makefile:1.1.1.1 linux-2.6.19/arch/powerpc/Makefile:1.2
> > --- linux-2.6.19/arch/powerpc/Makefile:1.1.1.1    Fri Oct  6 10:40:02 2006
> > +++ linux-2.6.19/arch/powerpc/Makefile    Fri Oct  6 12:26:35 2006
> > @@ -110,6 +110,7 @@
> >  CFLAGS       += -mcpu=powerpc
> >  endif
> >  
> > +cpu-as-$(CONFIG_PPC_CELL)    += -Wa,-mcellppu
> 
> We had this patch a while ago and I was told it's not needed anumore
> with a recent gcc.

We agree that it should not be merged to mainline.

We found that discussion in linuxppc64-dev ML archive. Though we need
this patch currently.

So we will cancel it.


Thank you,
Kou Ishizaki
Toshiba
