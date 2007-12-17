Return-Path: <haveblue@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1B5BFDDE2B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 06:17:22 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBHJHGMB030379
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 14:17:16 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBHJHGQh137882
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 14:17:16 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBHJHGKo000654
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 14:17:16 -0500
Subject: Re: 1st version of azfs
From: Dave Hansen <haveblue@us.ibm.com>
To: Maxim Shchetynin <maxim@de.ibm.com>
In-Reply-To: <OFE16CCD4C.0757B0AF-ONC12573B4.00642BAC-C12573B4.0066FFDD@de.ibm.com>
References: <OFE16CCD4C.0757B0AF-ONC12573B4.00642BAC-C12573B4.0066FFDD@de.ibm.com>
Content-Type: text/plain
Date: Mon, 17 Dec 2007 11:17:12 -0800
Message-Id: <1197919032.5385.39.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
	linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-12-17 at 19:45 +0100, Maxim Shchetynin wrote:
> please, have a look at the following patch. This is a first version of a
> non-buffered filesystem to be used on "ioremapped" devices.
> Thank you in advance for your comments.

Dude, your patch is line-wrapped to hell.  Please don't use Notes to
post patches.  

-- Dave
