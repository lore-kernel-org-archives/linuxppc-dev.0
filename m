Return-Path: <michel@tungstengraphics.com>
Received: from admin.zirkelwireless.com (admin.zirkelwireless.com
	[209.216.203.65])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8EEF167BD4
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 02:21:07 +1000 (EST)
Subject: Re: [PATCH] no-execute -- please test
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Albert Cahalan <acahalan@gmail.com>
In-Reply-To: <787b0d920608140908x391e926cs7c1023cb7ab5597f@mail.gmail.com>
References: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
	<1155547172.12664.115.camel@thor.lorrainebruecke.local>
	<787b0d920608140908x391e926cs7c1023cb7ab5597f@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 14 Aug 2006 18:20:57 +0200
Message-Id: <1155572457.12664.143.camel@thor.lorrainebruecke.local>
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

On Mon, 2006-08-14 at 12:08 -0400, Albert Cahalan wrote:
> The module failing is not actually the problem.
> I get GLcore failing with a numeric error message
> (grrr... like an original Mac or Amiga, or LILO)

What more explanation than 'undefined symbol' do you need? You're not
supposed to load GLcore explicitly, it'll be loaded automatically when
needed by the glx module.


The diff between the log files doesn't show any explanation as to why it
works in one case but doesn't in the other, maybe the difference really
lies on the client side?


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
