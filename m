Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C0352BDB5
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 09:26:44 +1100 (EST)
Received: from jack.colino.net (jack.colino.net [192.168.0.11])
	by paperstreet.colino.net (Postfix) with ESMTP id A6BCB73F5
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2004 23:26:09 +0100 (CET)
Date: Mon, 22 Nov 2004 23:26:06 +0100
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev@ozlabs.org
Message-ID: <20041122232606.67d9b2ed@jack.colino.net>
In-Reply-To: <1101162053.13597.136.camel@gaston>
References: <fc01eab7ddb069d0da7030a94b467f8f@nephilim.localdomain>
	<1101162053.13597.136.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: Test patch for sleep on Aluminium PowerBooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 23 Nov 2004 at 09h11, Benjamin Herrenschmidt wrote:

Hi, 

> > If filesystems do not need to be "normalized" at sleep, what 
> > filesystems are known to work?  (Hesistant about ext3, as it's quite
> > slow, imho, but I'll go that route if needed, I suppose).
> 
> It's not that slow ...

It also has the advantages of being natively big-endian, giving us ppc
users a bit more speed :)

-- 
 \|/ ____ \|/   Colin
 "@'/ ,. \`@"   http://www.geekounet.org/
 /_| \__/ |_\
    \__U_/
