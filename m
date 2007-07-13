Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7750EDDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 19:12:04 +1000 (EST)
Date: Fri, 13 Jul 2007 18:11:50 +0900 (JST)
Message-Id: <200707130911.l6D9Bq9G007319@toshiba.co.jp>
To: michael@ellerman.id.au
Subject: Re: [PATCH] fix showing xmon help
In-Reply-To: <1184284430.25007.5.camel@concordia.ozlabs.ibm.com>
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

> On Thu, 2007-07-12 at 16:59 +0900, Ishizaki Kou wrote:
> > In some configuration, xmon help string is larger than xmon output
> > buffer.  To show whole help string, this patch splits it into 2
parts.
> > 
> > Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
 (snip)

> I'm not sure I like the fix though, it's a bit of a kludge :)
> 
> We don't actually need to printf() the help string, so what'd be nicer
> is to add an xmon_puts() to arch/powerpc/xmon/nonstdio.c which just
> calls xmon_write(s, strlen(s)) and use that for printing the help
> string.

Thank you for your suggestion.

You're right. I'll send a new patch.

Best regards,
Kou Ishizaki
