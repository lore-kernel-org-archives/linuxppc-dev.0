Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B191367A7E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 06:20:54 +1100 (EST)
Date: Thu, 27 Jan 2005 19:52:05 +0100
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050127195205.192c8c28@jack.colino.net>
In-Reply-To: <1106012932.4533.46.camel@gaston>
References: <1106012932.4533.46.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH] radeonfb: massive update of PM code
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 18 Jan 2005 at 12h01, Benjamin Herrenschmidt wrote:

Hi Ben, 

> This patch is a quite massive update to radeonfb. It adds the ability
> to reboot from scratch the various chip models used on the recent
> powermac laptops, adds a bunch of new chips (including R420 support,
> untested), plus various fixes here or there including LCD & flat panel
> blanking, abuse of stack usage in radeonfb_set_par(), and finally,
> adapts the PM code to the recent powermac changes.

I just upgraded to 2.6.10, applied the 6 other patches you sent and this
one. This one makes some heavy video corruption on my iBook G4
(PowerBook6,3). The patch applies with a 27 lines offset at most hunks,
but does no rejects. 

I'm using xorg 6.7.0, and your test sleep patch #7 on 2.6.9 worked fine.

Tell me if I can be of any help...

Thanks!
-- 
Colin
  "Dinner not ready: (A)bort (R)etry (P)izza"
