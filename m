Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50E4BDDFAC
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 18:11:32 +1100 (EST)
Date: Thu, 25 Jan 2007 16:11:13 +0900 (JST)
Message-Id: <200701250711.l0P7BExX010484@toshiba.co.jp>
To: jens@de.ibm.com
Subject: Re: [PATCH 0/4] spidernet: add support for Celleb
In-Reply-To: <200701202210.36953.jens@de.ibm.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jens-san,

> > > This is a revised version of the patch set for spider_net driver
> > > that works on Toshiba Cell Refererence Set (aka Celleb).
> > >
> > > This patch set is based on netdev-2.6.git#upstream.
> >
> > Jens, can you give that a go on our blades see if it doesn't break
> > anything ? We are all at LCA here so it's a bit hard to test !
> 
> Nope, doesn't work for us...
> 
> I have a patch based on Ishizaki's previous patch which I think will work
> on Celleb. Will post it here when I have adapted it to the new version.

Thank you for testing our patch and we are sorry that our patch does
not work on Cell Blade.

We will test your modified patch on celleb when you post it.

Best regards,
Kou Ishizaki
