Return-Path: <michel@tungstengraphics.com>
Received: from admin.zirkelwireless.com (admin.zirkelwireless.com
	[209.216.203.65])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D1B867BDB
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 19:19:47 +1000 (EST)
Subject: Re: [PATCH] no-execute -- please test
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Albert Cahalan <acahalan@gmail.com>
In-Reply-To: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
References: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 14 Aug 2006 11:19:31 +0200
Message-Id: <1155547172.12664.115.camel@thor.lorrainebruecke.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-08-13 at 23:20 -0400, Albert Cahalan wrote:
> 
> If you want heap protection, change VM_DATA_DEFAULT_FLAGS32
> in include/asm-powerpc/page.h to be like VM_STACK_DEFAULT_FLAGS.
> I'd love to hear if anybody can get X to start with this change.
> For me (Xorg w/ ATI) a module load fails.

Which versions of the X server and driver, and which module fails to
load exactly how? As of X.Org 6.9, the X server no longer uses a custom
module loader but just dlopen and friends.


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
