Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BDF6467C36
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 06:47:32 +1000 (EST)
Subject: Re: [PATCH] pSeries  hvsi char driver janitorial cleanup.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20060803193643.GA10638@austin.ibm.com>
References: <20060803193643.GA10638@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 22:06:53 +0100
Message-Id: <1154639213.23655.124.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, hollisbl@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ar Iau, 2006-08-03 am 14:36 -0500, ysgrifennodd Linas Vepstas:
> Andrew, 
> Please apply.
> 
> A set of tty line discipline cleanup patches were introduced 
> before the dawn of time, in kernel version 2.4.21. This patch
> performs that cleanup for the hvsi driver.

Actually its also a bug fix, tty->ldisc should be locked by refcounting
and the helpers do this for you.

Acked-by: Alan Cox <alan@redhat.com>
