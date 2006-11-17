Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 130E267BDC
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 21:27:59 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id kAHARtAE017873
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 19:27:55 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id kAHARu4b012498
	for linuxppc-dev@ozlabs.org; Fri, 17 Nov 2006 19:27:56 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id kAHARt0O025187
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 19:27:55 +0900 (JST)
Date: Fri, 17 Nov 2006 19:27:54 +0900 (JST)
Message-Id: <200611171027.kAHARsYs020497@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/16] add base support for Celleb platform
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

Hello Christoph-san,

> > +         if(size-- <= 0) {
> > +             return NULL;
> > +         }

> No need for the {} braces for single line conditionals.  also
> please put a space in front of opening braces.  If you're unsure
> please take a look at Documentation/CodingStyle in the kernel tree.

> > + if((str = re_det1(str, &buf[0].cbuf[4], 4)) == NULL) {
> > +     return -1;
> > + }

> Similarly this should be written as:

>     str = re_det1(str, &buf[0].cbuf[4], 4);
>     if (!str)
>         return -1;

Thank you for your comment; these will be fixed at next time.

> And btw, all these function have very non-descriptive names
> and no comments.  That could use some work.  Also I'm not
> sure -N returns are very useful - you should at least have
> descriptive enums for the error cases.

We don't think these functions are useful for all kernel users,
since they work only on Beat. And, for debugging purpose, return values
indicate the locations of errors in above case, so we don't have enums
for these error cases. But it isn't easy to understand them without
comments as you mentioned, so we will add adequate comments at next time.

Thank you,
Kou Ishizaki
Toshiba
