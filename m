Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96030DDDF3
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 06:58:02 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IGhjl-0001lN-6H
	for linuxppc-dev@ozlabs.org; Thu, 02 Aug 2007 22:57:37 +0200
Received: from bi01p1.nc.us.ibm.com ([129.33.49.251])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Aug 2007 22:57:37 +0200
Received: from hollisb by bi01p1.nc.us.ibm.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Aug 2007 22:57:37 +0200
To: linuxppc-dev@ozlabs.org
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [patch 00/14] Current 4xx patch series
Date: Thu, 2 Aug 2007 20:57:26 +0000 (UTC)
Message-ID: <f8tgfm$e2g$1@sea.gmane.org>
References: <41060.0659474314$1184697204@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: news <news@sea.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 17 Jul 2007 13:15:47 -0500, Josh Boyer wrote:

> For those interested, here's my current 4xx patch series.  There are a few
> cleanups as a pre-requisite for 40x support, some minimal Walnut support, and
> another round of Bamboo patches.  These are all based off of Paul's current
> tree.

Bamboo is booting for me with your patches. Let's get them in soon...

> Ethernet for 4xx in general is still provided by the out-of-tree emac rewrite
> that Ben and David have poked at.  If it doesn't get merged soon, I'll take
> a look at getting it working again.

Please!

-- 
Hollis Blanchard
IBM Linux Technology Center
