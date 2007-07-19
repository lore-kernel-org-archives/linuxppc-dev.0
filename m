Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 56335DDE32
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 10:14:36 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 37/61] cpm2: Rework 8272ads initialization,
	and eliminate init_fcc_ioports().
Date: Thu, 19 Jul 2007 02:14:23 +0200
References: <20070718013548.GI15238@ld0162-tx32.am.freescale.net>
	<200707190204.44825.arnd@arndb.de>
In-Reply-To: <200707190204.44825.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707190214.23786.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 19 July 2007, Arnd Bergmann wrote:
> I guess you considered moving such tables into the device tree at some point,
> which doesn't seem that difficult at all to an ignorant reviewer like me.
> 
> What's the reasoning for putting it into the platform code after all?
> 

Ok, I think I found the answer myself: the table is for stuff that Linux
needs to set up, not to describe stuff that is already set up at the time
the device tree is parsed, right?

	Arnd <><
