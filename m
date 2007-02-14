Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 905E4DDE2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Feb 2007 10:10:01 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HHTFz-00089W-CJ
	for linuxppc-embedded@ozlabs.org; Thu, 15 Feb 2007 00:09:47 +0100
Received: from dsl-202-45-109-210-static.VIC.netspace.net.au ([202.45.109.210])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 15 Feb 2007 00:09:47 +0100
Received: from daniel_ng11 by dsl-202-45-109-210-static.VIC.netspace.net.au
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 15 Feb 2007 00:09:47 +0100
To: linuxppc-embedded@ozlabs.org
From: Daniel Ng <daniel_ng11@lycos.com>
Subject: Re: 'make' behaviour in BuildRoot
Date: Wed, 14 Feb 2007 23:09:31 +0000 (UTC)
Message-ID: <loom.20070215T000853-313@post.gmane.org>
References: <loom.20070214T072955-792@post.gmane.org>
	<97C76137-FF67-4145-BAF3-1AB3290F4D05@emi.yamaha.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> How about mounting the cramfs image and append 'test23' to '/usr'
> inside mounted image, then unmount the image.

Thanks for your comment Suzuki, I realise I can do it the way you suggested but 
what if I start adding several files, or edit some of these files? I would end 
up with a mounted system whose tree structure would be quite different to the 
one in 'build_powerpc/root'. This would just lead to confusion and more of my 
hair falling out. 

Surely I should just be able to type 'make' which would result in the tree 
structure updated in the cramfs image? Any ideas? Where are the BuildRoot 
experts out there? Can someone tell me how to subscribe to the BuildRoot list?

(Sorry I think my original example was a bit too simple).
