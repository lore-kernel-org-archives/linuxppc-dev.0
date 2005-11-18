Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E2426874D
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2005 09:19:10 +1100 (EST)
Date: Fri, 18 Nov 2005 23:19:04 +0100
From: Olaf Hering <olh@suse.de>
To: Hollis Blanchard <hollis@penguinppc.org>
Message-ID: <20051118221904.GA13068@suse.de>
References: <20051117210902.GB31775@suse.de>
	<437D0A21.4090803@smiths-aerospace.com>
	<20051118074237.GA14865@suse.de>
	<322e5a1c14e0e7a08d88868f23ec7c73@penguinppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <322e5a1c14e0e7a08d88868f23ec7c73@penguinppc.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc boot: replace string labels with numbers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Nov 18, Hollis Blanchard wrote:

> >The code should be obvious.
> 
> I hope the above was a joke, Olaf.

Not really. Perhaps I have been working on that code for too long now.
Its the string table that makes a difference.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
