Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 00FB867B6F
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 17:02:17 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id kBF62Ema027258
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 15:02:14 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id kBF62Etg017130
	for linuxppc-dev@ozlabs.org; Fri, 15 Dec 2006 15:02:14 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id kBF62EsE016343
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 15:02:14 +0900 (JST)
Message-Id: <200612150602.kBF62DU2025347@toshiba.co.jp>
MIME-Version: 1.0
Date: Fri, 15 Dec 2006 15:03:45 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: (Your message of "Thu, 14 Dec 2006 16:34:05 +1100")
	<1166074445.11914.310.camel@localhost.localdomain>
References: <200612140148.kBE1m8Bp008592@toshiba.co.jp>
	<1166074445.11914.310.camel@localhost.localdomain>
Subject: Re: [PATCH 10/15] celleb: SPU support routines
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>As much as I would have liked to integrate your code in 2.6.20, it seems
>that it won't be possible (as I told you privately earlier today). Linus
>is getting fairly strict about the 2 weeks window which closed... today.
>
>We'll merge the code in powerpc.git in the meantime, not in it's current
>form but after you have addresses some of the remaning comments. That
>way, it will be in -mm at least, and in the powerpc tree which means
>that from there, you won't have to rebase it every time we change
>something and it will get in first thing in 2.6.21 merge window.
>
>That will also give us more time to address some of the remaining issues
>that I'm not too happy with, like some of the PCI bits.

Then we will make efforts to merge our code in powerpc.git tree.
Next time, we will send patches and fix some problems in our code
as timely as possible.

>In general, code should be ready to merge -before- the merge window open
>or at worst during the first week, the second week being mostly to flush
>out bits that collided or needed rebasing etc...
>
>In a similar vein, while some of the PS3 code was actually merged, a lot
>of it wasn't yet (drivers etc...) are they are not ready, so it looks
>like 2.6.20 won't be the "big cell relase" but 2.6.21 will be instead.

We hope 2.6.21 will be the "big cell release", too.
To realize that, we will do the best.

Best regards,
Akira Iguchi
Toshiba
